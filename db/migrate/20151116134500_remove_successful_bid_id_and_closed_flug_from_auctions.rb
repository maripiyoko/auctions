class RemoveSuccessfulBidIdAndClosedFlugFromAuctions < ActiveRecord::Migration
  def change
    remove_column :auctions, :successful_bid_id, :integer
    remove_column :auctions, :closed, :boolean
  end
end
