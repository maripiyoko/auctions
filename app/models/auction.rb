class Auction < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  has_many :bids

  validates_presence_of :user_id, :product_id, :name, :min_price, :deadline_date

  scope :open_items, -> { where.not("deadline_date < ?", Time.current).order(deadline_date: :desc) }
  scope :close_items, -> { where("deadline_date < ?", Time.current).order(deadline_date: :desc) }

  def short_description
    self.description.each_line.first
  end

  def bidder?(user)
    self.bids.find_by(user: user).present?
  end

  def closed?
    self.deadline_date < Time.current
  end

  def max_bid_price
    self.bids.maximum(:price) || 0
  end

  def complete?
    self.closed? && self.max_bid_price > 0
  end

  def successful_bid
    self.bids.successful.order(price: :desc).first
  end

end
