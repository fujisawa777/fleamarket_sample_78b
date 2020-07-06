# README

# fleamarket_sample_78b DB設計

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|email|string|null: false,unique: true|
|password|string|null: false|
|updated_at|timestamp|null: false|
|created_at|timestamp|null: false|
### Association
- has_one: snscredential, dependent: :destroy
- has_one: sendaddress, dependent: :destroy
- has_one: personal, dependent: :destroy
- has_one: creditcard, dependent: :destroy
- has_many: products, through: :favorites, dependent: :destroy
- has_many: products, through: :comments, dependent: :destroy
- has_many: evaluations, dependent: :destroy
- has_many: buyer_products, class_name: 'User', foreign_key: 'buyer_id',dependent: :destroy
- has_many: seller_products, class_name: 'User', foreign_key: 'seller_id',dependent: :destroy

## Personalsテーブル
|Column|Type|Options|
|------|----|-------|
|birthday|date|null: false|
|firstname|string|null: false|
|lastname|string|null: false|
|h_firstname|string|null: false|
|h_lastname|string|null: false|
|image|string|default: 標準の画像|
|description|string||
|update_at|timestamp|null: false|
|created_at|timestamp|null: false|
|user_id|references|null: false,foreign_key: true|
### Association
- belongs_to: user

## Creditcardsテーブル
|Column|Type|Options|
|------|----|-------|
|customer_id|string|null: false,unique: true|
|token|string||
|user_id|references|null: false,foreign_key: true|
|update_at|timestamp|null: false|
|created_at|timestamp|null: false|
### Association
- belongs_to: user


## Favoritesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false,foreign_key: true|
|products_id|references|null: false,foreign_key: true|
|created_id|timestamp|null: false|
|updated_id|timestamp|null: false|
### Association
- belongs_to: user
- belongs_to: product

## Commentsテーブル
|Column|Type|Options|
|------|----|-------|
|content|text|null: false|
|user_id|references|null: false,foreign_key: true|
|products_id|references|null: false,foreign_key: true|
|created_id|timestamp|null: false|
|updated_id|timestamp|null: false|
### Association
- belongs_to: user
- belongs_to: product


## SnsCredentialsテーブル
|Column|Type|Options|
|------|----|-------|
|provider|string|null: false|
|uid|string|null: false,unique: true|
|token|string||
|user_id|references|null: false,foreign_key: true|
### Association
- belongs_to: user

## SendAddressesテーブル
|Column|Type|Options|
|------|----|-------|
|s_firstname|string|null: false|
|s_lastname|string|null: false|
|s_h_firstname|string|null: false|
|s_h_lastname|string|null: false|
|prefectures(jp_prefectures)|integer|null: false|
|municipalitities|string|null: false|
|zipcode|integer(7)|null: false|
|streetaddress|string|null: false|
|room|string||
|phonenumber|integer|null: false|
|update_at|timestamp|null: false|
|created_at|timestamp|null: false|
|user_id|references|null: false,foreign_key: true|
### Association
- belongs_to: user

## productsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|price|integer|null: false|
|discription|text|null: false|
|category_id|references|null: false,foreign_key: true|
|brand_id(acitve_hash)|integer||
|size_id(acitve_hash)|integer||
|staus_id(acitve_hash)|integer|null: false|
|shipfee_id(acitve_hash)|integer|null: false|
|shipregion_id(acitve_hash)|integer|null: false|
|estshipdate_id(acitve_hash)|integer|null: false|
|buyer_id|references|foreign_key: { to_table: :users }|
|seller_id|references|null: false,foreign_key: { to_table: :users }|
|draft|integer|null: false,default: 0|
|updated_at|timestamp|null: false|
|created_at|timestamp|null: false|
### Association
- has_many: comments, through: :users, dependent: :destroy
- has_many: favorites, through: :users, dependent: :destroy
- has_many: images, dependent: :destroy
- has_one: evalution,dependent: :destroy
- belongs_to :buyer, class_name: 'User', foreign_key: ‘buyer_id'
- belongs_to :seller, class_name: 'User', foreign_key: ‘seller_id'
- belongs_to_active_hash: categories
- belongs_to_active_hash: burands
- belongs_to_active_hash: size
- belongs_to_active_hash: statues
- belongs_to_active_hash: shipfees
- belongs_to_active_hash: shipreagons
- belongs_to_active_hash: estshipdate

## Evaluationsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false,foreign_key: true|
|item_id|references|null: false,foreign_key: true|
|evaluation_id(acitve_hash)|integer|null: false|
|review|text||
|created_id|timestamp|null: false|
|updated_id|timestamp|null: false|
### Association
- belongs_to_active_hash: evalutionsname
- belongs_to: user
- belongs_to: product


## EvaluationNamesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many: evaluations

## Imagesテーブル
|Column|Type|Options|
|------|----|-------|
|url|string|null: false|
|created_id|timestamp|null: false|
|updated_id|timestamp|null: false|
|product_id|integer|null: false,foreign_key: true|
### Association
- belongs_to: product

## Categoryテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|parent_id|integer||
|created_id|timestamp|null: false|
|updated_id|timestamp|null: false|
### Association
- has_many: products
- has_closure_tree

## Burandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many: products

## Sizes テーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many: products

## Statues テーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many: products

## Shipfees テーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many: products

## Shipreagons テーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many: products

## Estshipdate テーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many: products

