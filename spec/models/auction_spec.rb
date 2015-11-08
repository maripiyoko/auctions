require 'rails_helper'

RSpec.describe Auction, type: :model do

  it "should have a valid factory" do
    expect(FactoryGirl.create(:auction)).to be_valid
  end

end
