class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :purchaser_name
      t.string :item_description
      t.decimal :item_price
      t.integer :purchase_count
      t.string :merchant_addres
      t.string :merchant_name

      t.timestamps null: false
    end
  end
end
