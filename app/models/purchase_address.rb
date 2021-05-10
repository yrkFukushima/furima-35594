class PurchaseAddress
  include ActiveModel::Model

  attr_accessor :postal_code, :prefecture_id, :city, :address_line1, :address_line2, :tel, :purchase_id, :user_id, :item_id 
  
  with_options presence:true do
    validates :postal_code
    validates :prefecture_id
    validates :city
    validates :address_line1
    validates :tel
  end
  
  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address_line1: address_line1, address_line2: address_line2, tel: tel, purchase_id: purchase_id)
  end  
end  