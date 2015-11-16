class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :auction
  has_one :comment

  validates_presence_of :user_id, :auction_id, :price

  def acceptable_price?
    ### 『self.auction.min_price < self.price』だけで良さそうです。（『? true : false』は無くて良い）
    ### self.auction.min_price < self.price ? true : false
    self.auction.min_price < self.price
  end

  scope :successful, -> { joins(:auction).merge(Auction.close_items) }

  scope :user, -> (user) { where(user: user) }
end
