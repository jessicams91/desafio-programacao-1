class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.string :purchaser_name, null: false
      t.string :item_description, null: false
      t.decimal :item_price, null: false
      t.integer :purchase_count, null: false
      t.string :merchant_address, null: false
      t.string :merchant_name, null: false
      t.decimal :total_price
      t.references :order, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
