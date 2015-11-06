class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :auction

  validates_presence_of :user_id, :auction_id, :price
end
