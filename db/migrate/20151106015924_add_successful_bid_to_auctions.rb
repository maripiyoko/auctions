class AddSuccessfulBidToAuctions < ActiveRecord::Migration
  def change
    add_column :auctions, :successful_bid_id, :integer
    add_index :auctions, :successful_bid_id
    add_column :auctions, :closed, :boolean, default: false
  end
end
