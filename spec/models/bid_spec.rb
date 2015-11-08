require 'rails_helper'

RSpec.describe Bid, type: :model do

  it "should have a valid factory" do
    expect(FactoryGirl.create(:bid)).to be_valid
  end

end
