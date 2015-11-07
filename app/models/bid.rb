class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :auction
  has_one :comment

  validates_presence_of :user_id, :auction_id, :price

  def acceptable_price?
    self.auction.min_price < self.price ? true : false
  end

  scope :successful, -> { joins(:auction).merge(Auction.closed) }

  scope :user, -> (user) { where(user: user) }
end
