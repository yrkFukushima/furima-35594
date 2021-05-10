class PurchasesController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
  end  

  
  
  def create 
    # binding.pry
    @purchase_address = PurchaseAddress.new(purcase_params)
    if @purchase_address.valid?
      @purchase_address.save
      redirect_to root_path
    else
      render :index
    end  
  end
  
  def  purcase_params
    params.permit(:postal_code, :prefecture_id, :city, :address_line1, :address_line2, :tel, :item_id).merge(purchase_id: params[:token])
  end
end
