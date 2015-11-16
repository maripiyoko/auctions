class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :auction
  has_one :comment

  validates_presence_of :user_id, :auction_id, :price
  validates_numericality_of :price, only_integer: true, greater_than_or_equal_to: 0, less_than: 1_000_000

  before_save :acceptable_price?


  def acceptable_price?
    unless self.auction.min_price < self.price
      self.errors.add(:price, '入札金額が低すぎます。')
    end
    self.auction.min_price < self.price
  end

  scope :successful, -> { joins(:auction).merge(Auction.close_items) }

  scope :user, -> (user) { where(user: user) }
end
