class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :destroy]
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def destroy
    @order.destroy
 		redirect_to orders_path
  end

  def import
    begin
      if (file = params[:file]).nil?
        flash[:error] = "Erro: Você deve selecionar um arquivo!"
      elsif File.extname(file.original_filename) != ('.txt' && '.csv' && '.tsv' && '.tab')
        flash[:error] = "Erro: Formato de arquivo inválido."
      else
        @order = Order.new
        Order.import(file, @order)
        flash[:success] = "Pedido importado com sucesso"
      end
      redirect_to orders_path
    rescue
      flash[:error] = "Erro: O arquivo selecionado não pode ser importado."
      @order.destroy
      redirect_to orders_path
    end
  end

  private

  def set_order
    begin
  	   @order = Order.find(params[:id])
  	rescue
  		flash[:error] = "Erro: O pedido com id #{params[:id]} não existe."
  		redirect_to root_path
  	end
  end

  def order_params
    params.require(:order).permit(:filename, :price)
  end
end
