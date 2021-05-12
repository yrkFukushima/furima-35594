FactoryBot.define do
  factory :purchase_address do
    postal_code   {'123-4567'}
    prefecture_id {2}
    city          { '千代田区' }
    address_line1 {'1-1'}
    address_line2 {'千代田ハイツ'}
    tel           {'00000000000'}
    token         {"tok_abcdefghijk00000000000000000"}
  end
end
