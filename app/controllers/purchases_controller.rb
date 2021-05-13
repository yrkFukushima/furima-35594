class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :item_set, only: [:index, :create]
  before_action :user_set
  
  def index
    @purchase_address = PurchaseAddress.new
  end  

  
  
  def create
    @purchase_address = PurchaseAddress.new(purchase_params)
    if @purchase_address.valid?
      pay_item 
      @purchase_address.save
      redirect_to root_path
    else
      render :index
    end 
  end

  
  
  def  purchase_params
    params.require(:purchase_address).permit(:postal_code, :prefecture_id, :city, :address_line1, :address_line2, :tel).merge(user_id: current_user.id, item_id: @item.id,token: params[:token])
  end


  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,  
      card: purchase_params[:token],   
      currency: 'jpy')
  end

  def item_set
    @item = Item.find(params[:item_id])
  end  



  def user_set
    if @item.purchase.present? || current_user.id == @item.user_id
      redirect_to root_path
    end  
  end  
end
