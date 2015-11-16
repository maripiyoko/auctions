class Auction < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  has_many :bids
  has_one :successful_bid, class_name: "Bid", primary_key: :successful_bid_id, foreign_key: :id

  validates_presence_of :user_id, :product_id, :name, :min_price, :deadline_date

  before_save :close_auction_if_needed
  before_update :reopen_if_needed

  def short_description
    self.description.each_line.first
  end

  def bidder?(user)
    self.bids.find_by(user: user).present?
  end

  scope :over_deadline_date, -> { where("deadline_date < ?", Time.current) }

  scope :open, -> { where(closed: false).order(deadline_date: :desc) }
  scope :closed, -> { where(closed: true).order(deadline_date: :desc) }

  def self.close_all_over_deadline_auctions!
    self.over_deadline_date.open.each do |auction|
      auction.save
    end
  end

  # オークションを終了する（締め処理）
  def close_auction_if_needed
    if self.deadline_date < Time.current
      unless self.closed
        # オークションはまだ終了していない。締め処理開始
        max_bid = self.bids.max_by { |b| b.price }
        if max_bid.present? && max_bid.price > self.min_price
          # 最高額の入札を確定
          self.successful_bid_id = max_bid.id
        end
      end
      # オークション終了
      self.closed = true
    end
    true
  end

  # 既に一度クローズされているオークションを再オープンする場合のチェック
  # 落札がなければ再オープンできる
  def reopen_if_needed
    if self.deadline_date > Time.current && self.closed && self.successful_bid.nil?
      self.closed = false
    end
    true
  end

  def max_bid_price
    max_bid = self.bids.max_by { |b| b.price }
    if max_bid.present?
      max_bid.price
    else
      0
    end
  end

end
