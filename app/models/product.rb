class Product < ActiveRecord::Base
  belongs_to :user

  has_many :auctions

  validates_presence_of :user_id, :name

  def short_description
    self.description.each_line.first
  end

end
