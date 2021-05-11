class PurchaseAddress
  include ActiveModel::Model

  attr_accessor :postal_code, :prefecture_id, :city, :address_line1, :address_line2, :tel, :user_id, :item_id, :token
  
  with_options presence:true do
    validates :postal_code, 
      format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :prefecture_id,
      numericality: {other_than: 0, message: "can't be blank"}
    validates :city
    validates :address_line1
    validates :tel,
    length: { maximum: 11},
    format: {with: /\A[0-9]+\z/}
    validates :token
  end
  
  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address_line1: address_line1, address_line2: address_line2, tel: tel, purchase_id: purchase.id)
  end  
end  