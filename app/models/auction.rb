class Auction < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  has_many :bids

  ### successful_bid_idカラムが無くても実装できそう。代わりにメソッド化
  # has_one :successful_bid, class_name: "Bid", primary_key: :successful_bid_id, foreign_key: :id

  validates_presence_of :user_id, :product_id, :name, :min_price, :deadline_date

  ### closedカラム使わなければ不要
  # before_update :check_deadline_date_and_set_closed_if_needed

  def short_description
    self.description.each_line.first
  end

  def bidder?(user)
    self.bids.find_by(user: user).present?
  end

  ### 細かいですが、メソッド定義とメソッド定義の間にスコープ定義の記述があるのがちょっと気になります。

  # scope :over_deadline_date, -> { where("deadline_date < ?", Time.current) }

  ### closedカラムは無くても実装できそうに思いました（パフォーマンスを考慮されているのかもしれませんが）
  # scope :open, -> { where(closed: false).order(deadline_date: :desc) }
  # scope :closed, -> { where(closed: true).order(deadline_date: :desc) }
  scope :open_items, -> { where.not("deadline_date < ?", Time.current).order(deadline_date: :desc) }
  scope :close_items, -> { where("deadline_date < ?", Time.current).order(deadline_date: :desc) }

  ### closedカラムの代わりのメソッド
  def closed?
    self.deadline_date < Time.current
  end


  ### closedカラムは無くても実装できそうに思いました
  # # オークションを終了する（締め処理）
  # def close!
  #   if self.deadline_date < Time.current
  #     unless self.closed
  #       # オークションはまだ終了していない。締め処理開始
  #       max_bid = self.bids.max_by { |b| b.price }
  #       if max_bid.present? && max_bid.price > self.min_price
  #         # 最高額の入札を確定
  #         self.successful_bid_id = max_bid.id
  #       end
  #     end
  #     # オークション終了
  #     self.closed = true
  #     pp 'オークション終了！'
  #     self.save!
  #     true
  #   end
  #   false
  # end

  def max_bid_price
    ### こうすれば１行で書けそうです。
    # max_bid = self.bids.max_by { |b| b.price }
    # if max_bid.present?
    #   max_bid.price
    # else
    #   0
    # end
    max_bid = self.bids.maximum(:price) || 0
  end

  ### closedカラムは無くても実装できそうに思いました（パフォーマンスを考慮されているのかもしれませんが）
  # def self.close_all_over_deadline_auctions!
  #   self.over_deadline_date.open.each do |auction|
  #     auction.close!
  #   end
  # end
  #
  # def check_deadline_date_and_set_closed_if_needed
  #   if self.deadline_date < Time.current
  #     self.closed = true
  #   else
  #     self.closed = false if self.can_reopen?
  #     true
  #   end
  # end

  ### 使わなくなったので消します。
  # 既に一度クローズされているオークションを再オープンする場合のチェック
  # 落札がなければ再オープンできる
  # def can_reopen?
  #   self.closed? && self.successful_bid.nil?
  # end

  ### 上のcan_reopen?ぽいやつが必要だったので作りました
  def complete?
    self.closed? && self.max_bid_price > 0
  end

  ### 上のhas_one :successful_bidの代わり
  def successful_bid
    self.bids.successful.order(price: :desc).first
  end

end
