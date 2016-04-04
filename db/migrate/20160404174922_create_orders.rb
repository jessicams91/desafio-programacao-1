class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.decimal :price
      t.string :filename

      t.timestamps null: false
    end
  end
end
