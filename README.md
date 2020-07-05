# README

# fleamarket_sample_78b DB設計

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|email|string|null: false,unique: true|
|password|string|null: false|
|c_password|string|null: false|
|updated_at|timestamp|null: false|
|created_at|timestamp|null: false|
### Association
- has_one: snscredential, dependent: :destroy
- has_one: sendaddress, dependent: :destroy
- has_one: personal, dependent: :destroy
- has_one: creditcard, dependent: :destroy
- has_many: favorites, through: :products, dependent: :destroy
- has_many: comments, through: :products, dependent: :destroy
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
|customer_id|integer|null: false,unique: true|
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
|prefectures|integer|null: false|
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
|image_id|references|null: false,foreign_key: true|
|price|integer|null: false|
|discription|text|null: false|
|category_id|references|null: false,foreign_key: true|
|brand_id|references|foreign_key: true|
|size_id|references|foreign_key: true|
|staus_id|references|null: false,foreign_key: true|
|shipfee_id|string|null: false,foreign_key: true|
|shipregion_id|string|null: false,foreign_key: true|
|estshipdate_id|references|null: false,foreign_key: true|
|favorite _id|references|foreign_key: true|
|comment_id|references|foreign_key: true|
|buyer_id|references|foreign_key: { to_table: :users }|
|seller_id|references|null: false,foreign_key: { to_table: :users }|
|draft|integer|null: false,default: 0|
|sold|integer|null: false,default: 0|
|updated_at|timestamp|null: false|
|created_at|timestamp|null: false|
### Association
- has_many: comments, through: :users, dependent: :destroy
- has_many: favorites, through: :users, dependent: :destroy
- has_many: images, dependent: :destroy
- has_one: evalution,dependent: :destroy
- belongs_to :buyer, class_name: 'User', foreign_key: ‘buyer_id'
- belongs_to :seller, class_name: 'User', foreign_key: ‘seller_id'
- belongs_to_active_hash: categories, dependent: :destroy
- belongs_to_active_hash: burands, dependent: :destroy
- belongs_to_active_hash: size, dependent: :destroy
- belongs_to_active_hash: statues, dependent: :destroy
- belongs_to_active_hash: shipfees, dependent: :destroy
- belongs_to_active_hash: shipreagons, dependent: :destroy
- belongs_to_active_hash: estshipdate, dependent: :destroy


## Evaluationsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false,foreign_key: true|
|item_id|references|null: false,foreign_key: true|
|evaluation_id|references|null: false,foreign_key: true|
|review|text||
|created_id|timestamp|null: false|
|updated_id|timestamp|null: false|
### Association
- belongs_to_active_hash: evalutionsname
- belongs_to: user
- belongs_to: product


## EvaluationNames gem active_hash
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many: evaluations


## Imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|created_id|timestamp|null: false|
|updated_id|timestamp|null: false|
|products_id|integer|null: false,foreign_key: true|
### Association
- belongs_to: product

## categoryテーブル
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
|image|string|null: false|
### Association
- has_many: products

## estshipdate テーブル
|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
### Association
- has_many: products

