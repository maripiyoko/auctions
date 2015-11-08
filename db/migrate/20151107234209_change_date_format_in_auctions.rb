class ChangeDateFormatInAuctions < ActiveRecord::Migration
  def change
    change_column :auctions, :deadline_date, :datetime
  end
end
