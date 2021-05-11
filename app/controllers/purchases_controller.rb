class PurchasesController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
    @purchase_address = PurchaseAddress.new
  end  

  
  
  def create
    @item = Item.find(params[:item_id])
    @purchase_address = PurchaseAddress.new(purchase_params)
    if @purchase_address.valid?
      @purchase_address.save
      redirect_to root_path
    else
      render :index
    end 
  end
  
  def  purchase_params
    params.require(:purchase_address).permit(:postal_code, :prefecture_id, :city, :address_line1, :address_line2, :tel, :item_id).merge(user_id: current_user.id)
  end
end
