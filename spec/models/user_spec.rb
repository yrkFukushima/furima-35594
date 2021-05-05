require 'rails_helper'

RSpec.describe User, type: :model do
  before do 
    @user = FactoryBot.build(:user)
  end
  
  describe 'ユーザー新規登録' do
    context 'ユーザー新規登録ができる時' do
      it '情報が正しく入力されていれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context 'ユーザー新規登録ができない時' do
      it'nicknameが空では登録できない' do
      @user.nickname= ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank") 
      end
      it 'emailが空では登録できない' do
      @user.email= ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank") 
      end
      it '重複したemailが存在する場合登録できない' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
      end 
      it 'emailに@がない場合は登録できない' do
      @user.email = 'test'
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid") 
      end
      it 'passwordが空では登録できない' do
      @user.password= ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank") 
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
      @user.password= 'aaa111'
      @user.password_confirmation =''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password") 
      end
      it 'passwordが5文字以下では登録できない' do
      @user.password = 'aa111'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'passwordが半角英数字混合でないと登録できない' do
        @user.password = 'aaaaaaa'
        @user.password_confirmation = 'aaaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end  
      it 'passwordが数字のみでは登録できない' do
      @user.password = '123456'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it 'passwordが全角では登録できない' do
        @user.password = 'ああああああ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end 
      it 'last_nameが空では登録できない' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank") 
      end
      it 'first_nameが空では登録できない' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'first_name_kanaが空では登録できない' do 
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank") 
      end
      it 'last_nameが全角入力でなければ登録できない' do
        @user.last_name = 'abc'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid") 
      end
      it 'first_nameが全角入力でなければ登録できない' do
        @user.first_name = 'abc'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid") 
      end
      it 'last_name_kanaが全角カナ入力でなければ登録できない' do
        @user.last_name_kana = 'abc'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid") 
      end
      it 'first_name_kanaが全角カナ入力でなければ登録できない' do
        @user.first_name_kana = 'abc'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid") 
      end
      it 'birthdayが空だと登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank") 
      end  
    end
  end
end
