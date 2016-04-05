require "rails_helper"
include ActionDispatch::TestProcess

RSpec.describe Order, :type => :model do
 	describe "Testing import method" do
 		it "should import file with order_items" do
 			file = fixture_file_upload("files/test_input.tab", "text/plain")
 			order = FactoryGirl.build(:order)
 			Order.import(file, order)

 			order_items = OrderItem.where(order_id: order.id)
 			expect(order_items).not_to be_nil

 			order_items_prices = order_items.map {|item| item["total_price"]}.reduce(0, :+)
 			expect(order.price).to eq order_items_prices

 			expect(order.filename).to eq file.original_filename
 		end

 		it "should import empty file" do
 			file = fixture_file_upload("files/empty_input.tab", "text/plain")
 			order = FactoryGirl.build(:order)
 			Order.import(file,order)

 			order_items = OrderItem.where(order_id: order.id)
 			expect(order_items).to be_empty

 			expect(order.price).to eq 0.0

      expect(order.filename).to eq file.original_filename
 		end

 		it "should not import nil file" do
 			order = FactoryGirl.build(:order)
 			expect{Order.import(nil, order)}.to raise_error("Arquivo é nulo!")
 		end
 	end
end
