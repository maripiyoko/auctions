require 'rails_helper'

RSpec.describe Product, type: :model do

  it "should have a valid factory" do
    expect(FactoryGirl.create(:product)).to be_valid
  end

end
