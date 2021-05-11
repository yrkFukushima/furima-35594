class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

      has_many :items
      has_one :purchase
    

  with_options presence: true do    
    validates :nickname
    validates :password,
      format: {with: /\A(?=.*?[a-z])(?=.*?[\d])\w{6,12}\z/}
    with_options format: { with: /\A([ぁ-んァ-ン一-龥]|ー)+\z/} do
      validates :first_name
      validates :last_name
    end  
    with_options format: { with: /\A([ァ-ン]|ー)+\z/} do
      validates :first_name_kana
      validates :last_name_kana
    end
    validates :birthday
  end
end
