class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.string :name, null: false
      t.text :description
      t.references :user, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true
      t.integer :min_price
      t.date :deadline_date

      t.timestamps null: false
    end
  end
end
