class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :auction
  has_one :comment

  validates_presence_of :user_id, :auction_id, :price
  validates_numericality_of :price, only_integer: true, greater_than_or_equal_to: 0, less_than: 1_000_000


  def acceptable_price?
    if self.auction.min_price < self.price
      true
    else
      self.errors.add(:price, '入札金額が低すぎます。')
      false
    end
  end

  scope :successful, -> { joins(:auction).merge(Auction.closed) }

  scope :user, -> (user) { where(user: user) }
end
