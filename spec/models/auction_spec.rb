require 'rails_helper'

RSpec.describe Auction, type: :model do

  it "should have a valid factory" do
    expect(FactoryGirl.create(:auction)).to be_valid
  end

  context "close auction" do
    let(:target_date) { Date.tomorrow.noon }
    let(:auction) { FactoryGirl.create(:auction, { deadline_date: target_date }) }

    it "should not closed at first" do
      expect(auction.closed).to be_falsey
    end

    context "over deadline_date auction" do
      it "should closed when deadline_date past" do
        Timecop.travel(target_date + 1.hour)
        expect(auction.closed?).to be_truthy
        expect(auction.successful_bid).to be_nil
      end

      it "should have successful_bid if it has higher price bid" do
        bid = FactoryGirl.create(:bid, { auction: auction, price: auction.min_price + 1000 })
        Timecop.travel(target_date + 1.hour)
        expect(auction.successful_bid).to eq(bid)
      end

      it "can be re-open if no successful_bid" do
        auction.deadline_date = 1.hour.ago
        expect(auction.closed?).to be_truthy
        expect(auction.successful_bid).to be_nil
        expect(auction.complete?).to be_falsey
        auction.deadline_date = target_date + 1.day
        expect(auction.valid?).to be_truthy
      end

      it "should NOT be re-open if it has a successful_bid" do
        FactoryGirl.create(:bid, { auction: auction, price: auction.min_price + 1000 })
        Timecop.travel(target_date + 1.hour)
        expect(auction.closed?).to be_truthy
        expect(auction.successful_bid).not_to be_nil
        expect(auction.complete?).to be_truthy
        auction.deadline_date = target_date + 1.day
        auction.save
        expect(auction.save).to be_falsey
      end

    end

  end
end
