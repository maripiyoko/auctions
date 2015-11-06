class Auction < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  has_many :bids
  has_one :successful_bid, class_name: "Bid", foreign_key: :id

  validates_presence_of :user_id, :product_id, :name, :min_price, :deadline_date

  def short_description
    self.description.each_line.first
  end

  def bidder?(user)
    self.bids.find_by(user: user).present?
  end

  scope :over_deadline_date, -> { where("deadline_date < ?", Time.now) }

  scope :open, -> { where(closed: false).order(deadline_date: :desc) }

  # オークションを終了する（締め処理）
  def close!
    if self.deadline_date < Time.now
      if !self.closed && self.successful_bid.nil?
        # オークションはまだ終了していない。締め処理開始
        max_bid = self.bids.max_by { |b| b.price }
        if max_bid.present? && max_bid.price > self.min_price
          # 最高額の入札を確定
          self.successful_bid = max_bid
        end
      end
      # オークション終了
      self.closed = true
      pp 'オークション終了！'
      self.save!
      true
    end
    false
  end

  def max_bid_price
    max_bid = self.bids.max_by { |b| b.price }
    if max_bid.present?
      max_bid.price
    else
      0
    end
  end

  def self.close_all_over_deadline_auctions!
    self.over_deadline_date.open.each do |auction|
      auction.close!
    end
  end

end
