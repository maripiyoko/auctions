class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.references :user, index: true, foreign_key: true
      t.references :auction, index: true, foreign_key: true
      t.integer :price, default: 0, nil: false

      t.timestamps null: false
    end

    add_index :bids, [ :user_id, :auction_id ], unique: true
  end
end
