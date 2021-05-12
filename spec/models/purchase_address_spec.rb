require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  describe '購入者情報の保存' do
    before do 
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      sleep(1)
      @purchase_address = FactoryBot.build(:purchase_address, user_id: user.id , item_id: item.id)
 
    end  

    context '内容に問題がない場合' do
      it '全ての情報が正しく入力されていれば保存できること' do
        expect(@purchase_address).to be_valid
      end
      it '建物名がからでも保存できる' do
        @purchase_address.address_line2 = ''
        @purchase_address.valid?
        expect(@purchase_address).to be_valid
      end
    end   


    context '内容に問題がある場合' do
      it 'postal_codeが空だと保存できない' do
        @purchase_address.postal_code = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'postal_codeが半角のハイフンを含んでいないと保存できない' do
        @purchase_address.postal_code = '1234567'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end

      it 'prefectureが選択されていないと保存できない' do
        @purchase_address.prefecture_id = 0
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'cityが入力されていないと保存できない' do
        @purchase_address.city = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("City can't be blank")
      end

      it 'address_line1が入力されていないと保存できない' do
        @purchase_address.address_line1 = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Address line1 can't be blank")
      end

      it 'telが入力されていないと保存できない' do
        @purchase_address.tel = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Tel can't be blank")
      end

      it 'telが全角入力だと保存できない' do
        @purchase_address.tel = '１００００００００００'
        @purchase_address.valid?   
        expect(@purchase_address.errors.full_messages).to include("Tel is invalid")
      end

      it 'telが11桁以上だと保存できない' do
        @purchase_address.tel = '000000000000000'
        @purchase_address.valid?   
        expect(@purchase_address.errors.full_messages).to include("Tel is too long (maximum is 11 characters)")
      end

      it 'telが英数字混合だと保存できない' do
        @purchase_address.tel = '12345aaaaaa'
        @purchase_address.valid?   
        expect(@purchase_address.errors.full_messages).to include("Tel is invalid")
      end

      it "tokenが空では保存できない" do
        @purchase_address.token = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Token can't be blank")
      end

      it "user_idが空では保存できない" do
        @purchase_address.user_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("User can't be blank")
      end

      it "item_idが空では保存できない" do
        @purchase_address.item_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Item can't be blank")
      end
    end   

  end  
end
