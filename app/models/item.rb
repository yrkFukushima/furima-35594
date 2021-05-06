class Item < ApplicationRecord

  belongs_to :user
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :delivery_charge
  belongs_to :delivery_time
  belongs_to :prefecture

  with_options presence:true do
    validates :name
    validates :intoroduction
    validates :category_id
    validates :status_id
    validates :delivery_charge_id
    validates :prefecture_id
    validates :delivery_time_id
    validates :price
end
