class Auction < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  validates_presence_of :user_id, :product_id, :name, :min_price, :deadline_date

  def short_description
    self.description.each_line.first
  end
end
