class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :bid, index: true, foreign_key: true, null: false
      t.string :evaluation, null: false
      t.text :comment

      t.timestamps null: false
    end
  end
end
