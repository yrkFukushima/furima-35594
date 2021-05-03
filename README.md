# README
## users テーブル

| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| nickname | string | null: false |
| email    | string | null: false |
| password | string | null: false |
| name     | string | null: false |
| ruby     | string | null: false |
| birthday | string | null: false |

### Association

- has_many :items
- has_many :comments
- has_many :customers


## items テーブル
| Column          | Type   | Options     |
| --------------- | ------ | ----------- |
| item_name       | string | null: false |
| introduction    | text   | null: false |
| category        | string | null: false |
| status          | string | null: false |
| delivery_charge | string | null: false |
| consignor       | string | null: false |
| delivery_time   | string | null: false |
| price           | string | null: false |

### Association

- belongs_to :user
- has_many :comment
- has_one :customer

## comments　テーブル
| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| comment | string     | null: false                    |
| user    | references | null: false, foreign_key: true |
| item    | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item

## customersテーブル

| Column          | Type       | Options                        |
| --------------- | -----------| ------------------------------ |
| card_number     | string     | null: false                    |
| expiration_date | string     | null: false                    |
| cvc             | string     | null: false                    |
| item            | references | null: false, foreign_key: true |
| user            | references | null: false, foreign_key: true |

### Association
- belongs_to :item
- belongs_to :user
- has_one :address

## addressテーブル

 Column         | Type       | Options                        |
| --------------| ---------- | ------------------------------ |
| postal_code   | string     | null: false                    |
| prefecture    | string     | null: false                    |
| city          | string     | null: false                    |
| address_line1 | string     | null: false                    |
| address_line2 | string     |                                |
| tel           | string     | null: false                    |
| customer      | references | null: false, foreign_key: true |

## Association
- belongs_to :customer
