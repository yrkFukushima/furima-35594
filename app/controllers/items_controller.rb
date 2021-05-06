class ItemsController < ApplicationController

  def index
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
    @items = Item.all
  end  

  private
  def item_params
    params.require(:item).permit(:name, :introduction, :category_id, :status_id, :delivery_charge_id, :prefecture_id, :delivery_time_id, :price,:image).merge(user_id: current_user.id)
  end
end
