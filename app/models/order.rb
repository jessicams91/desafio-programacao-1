class Order < ActiveRecord::Base
  has_many :order_item
  def self.import(file, order)
    order_price = 0.0
    if file.nil?
      raise "Arquivo é nulo!"
    else
      CSV.foreach(file.path, {headers: true, col_sep: "\t", header_converters: :symbol}) do |item|
        order_item = OrderItem.create! item.to_hash
        total_price = order_item.item_price * order_item.purchase_count
        order_item.update(order: order, total_price: total_price)
        order_price += order_item.total_price
      end
      order_price
    end
  end
end
