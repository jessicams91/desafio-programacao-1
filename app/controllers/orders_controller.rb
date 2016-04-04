class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def import
    begin
      if (file = params[:file]).nil?
        flash[:error] = "Erro: Você deve selecionar um arquivo!"
      else
        @order = Order.create!(filename: file.original_filename)
        @price = Order.import(file, @order)
        @order.update(price: @price) if @price
        redirect_to orders_path, notice: "Order imported."
      end
    rescue
      flash[:error] = "Erro: O arquivo selecionado não pode ser importado."
      @order.destroy
      redirect_to root_path
    end
  end
end
