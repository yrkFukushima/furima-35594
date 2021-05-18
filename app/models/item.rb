class Item < ApplicationRecord

  belongs_to :user
  has_many_attached :images
  has_one :purchase
  has_many :comments
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :delivery_charge
  belongs_to :delivery_time
  belongs_to :prefecture


  with_options presence:true do
    validates :name,
      length: { maximum: 40}
    validates :introduction,
      length: { maximum: 1000}
    with_options  numericality: { other_than: 1 } do
    validates :category_id
    validates :status_id
    validates :delivery_charge_id
    validates :prefecture_id
    validates :delivery_time_id
    end
    validates :price,
    numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 },
    format: {with: /\A[0-9]+\z/}
    validates :images,
    length: {maximum:4}
  end  
end
