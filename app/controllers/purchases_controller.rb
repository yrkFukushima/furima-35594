class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :item_set, only: [:index, :create]
  before_action :user_set
  
  def index
    @purchase_address = PurchaseAddress.new
    
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    card = Card.find_by(user_id: current_user.id) 
    
    if card.present?
      customer = Payjp::Customer.retrieve(card.customer_token) # 先程のカード情報を元に、顧客情報を取得
      @card = customer.cards.first
    end
  end  

  
  
  def create
    @purchase_address = PurchaseAddress.new(purchase_params)
    card = Card.find_by(user_id: current_user.id) 
      if card.present?
        customer = Payjp::Customer.retrieve(card.customer_token)
        @card = customer.cards.first
        @purchase_address.token = current_user.card.customer_token
      end  

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

  def address_params
    params.require(:purchase_address).permit(:postal_code, :prefecture_id, :city, :address_line1, :address_line2, :tel).merge(user_id: current_user.id, item_id: @item.id)
  end  


  def pay_item
    if @card.present?
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      customer_token = current_user.card.customer_token
      Payjp::Charge.create(
        amount: @item.price,
        customer: customer_token,
        currency: 'jpy' 
    )
    else
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price,  
        card: purchase_params[:token],   
        currency: 'jpy')
    end
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

