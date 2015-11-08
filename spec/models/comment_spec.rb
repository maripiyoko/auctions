require 'rails_helper'

RSpec.describe Comment, type: :model do

  it "should have a valid factory" do
    expect(FactoryGirl.create(:comment)).to be_valid
  end

end
