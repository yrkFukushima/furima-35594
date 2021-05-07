require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  
  describe '商品の出品' do
    context '商品の保存ができる場合'do
      it '全ての項目が正しく記入されていれば保存ができる' do
        expect(@item).to be_valid
      end  
    end
    context '商品の保存ができない場合'do
      it '画像がないと保存できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end  
      it '商品名がないと保存できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end  
      it '商品の説明がないと保存できない' do
        @item.introduction = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Introduction can't be blank")
      end  
      it 'カテゴリーの情報が選択されていないと保存できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 1")
      end 
      it '配送料の負担についての情報が選択されていないと保存できない' do
        @item.delivery_charge_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery charge must be other than 1")
      end 
      it '発送元の地域についての情報が選択されていないと保存できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture must be other than 1")
      end
      it '商品の状態についての情報が選択されていないと保存できない' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Status must be other than 1")
      end
      it '発送までの日数についての情報が選択されていないと保存できない' do
        @item.delivery_time_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery time must be other than 1")
      end
      it '販売価格についての情報がないと保存できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it '販売価格が300以下だと保存できない' do
        @item.price = 200
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end
      it '販売価格が9,999,999以上だと保存できない' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end
      it '販売価格が全角入力だと保存できない' do
        @item.price = '３００００'
        @item.valid? 
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it '販売価格が半角英数字混合入力だと保存できない' do
        @item.price = 'abc123'
        @item.valid? 
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it '販売価格が半角英数字のみだと保存できない' do
        @item.price = 'abcdef'
        @item.valid? 
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      
    end
  end
end
