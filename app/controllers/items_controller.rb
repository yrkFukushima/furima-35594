class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new, :edit, :update]
  before_action :item_set, only: [:show, :edit, :update, :destroy]
  before_action :user_set, only: [:edit, :update]

  def index
    @items = Item.all.order("created_at DESC")
  end

  def new
  @item = Item.new
  end

  def create
    @item= Item.new(item_params)
    if @item.save
      redirect_to root_path
    else  
      render :new
    end  
  end  

  def show
  end  

  def edit
  end  

  def  update
    if @item.update(item_params)
      redirect_to item_path(params[:id])
    else
        render :edit
    end    
  end  

  def destroy
    @item.destroy
    redirect_to root_path
  end  

  private
  def item_params
    params.require(:item).permit(:name, :introduction, :category_id, :status_id, :delivery_charge_id, :prefecture_id, :delivery_time_id, :price,:image).merge(user_id: current_user.id)
  end

  def item_set
    @item = Item.find(params[:id])

  end  

  def user_set
    unless current_user.id == @item.user_id
      redirect_to root_path
    end
  end  
end

