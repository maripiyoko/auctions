class Comment < ActiveRecord::Base
  extend Enumerize

  belongs_to :bid
  belongs_to :user

  validates_presence_of :user_id, :auction_id, :evaluation

  EVALUATIONS = %w(
    悪い
    普通
    良い
  ).freeze
  enumerize :evaluation, in: EVALUATIONS
  validates :evaluation, inclusion: { in: EVALUATIONS }

end
