require 'rails_helper'

RSpec.describe Auction, type: :model do

  it "should have a valid factory" do
    expect(FactoryGirl.create(:auction)).to be_valid
  end

  context "close auction" do
    let(:auction) { FactoryGirl.create(:auction, { deadline_date: Date.tomorrow.noon }) }

    it "should not closed at first" do
      expect(auction.closed).to be_falsey
    end

    context "over deadline_date auction" do
      it "should closed when close! method call" do
        auction.deadline_date = 1.hour.ago
        auction.save
        expect(auction.closed).to be_truthy
        expect(auction.successful_bid).to be_nil
      end

      it "should have successful_bid if it has higher price bid" do
        bid = FactoryGirl.create(:bid, { auction: auction, price: auction.min_price + 1000 })
        auction.deadline_date = 1.hour.ago
        auction.save
        expect(auction.successful_bid).to eq(bid)
      end

      it "can be re-open if no successful_bid" do
        auction.deadline_date = 1.hour.ago
        auction.save
        expect(auction.closed).to be_truthy
        expect(auction.successful_bid).to be_nil
        auction.deadline_date = Time.now.tomorrow
        auction.save
        expect(auction.closed).to be_falsey
      end

      it "should NOT be re-open if it has a successful_bid" do
        FactoryGirl.create(:bid, { auction: auction, price: auction.min_price + 1000 })
        auction.deadline_date = 1.hour.ago
        auction.save
        expect(auction.closed).to be_truthy
        expect(auction.successful_bid).not_to be_nil
        auction.deadline_date = Time.now.tomorrow
        auction.save
        expect(auction.closed).to be_truthy
      end

    end

  end
end
