class Auction < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  validates_presence_of :user_id, :product_id, :name
end
