# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


# fleamarket_sample_78b DB設計

## personalテーブル
|Column|Type|Options|
|------|----|-------|
|birthday|integer|null: false|
|firstname|string|null: false|
|lastname|string|null: false|
|firstfurigana|string|null: false|
|lastfurigana|string|null: false|
### Association
- has_one :adress
- has_many :comments

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false|
|password|string|null: false|
|created_at|datatime|null: false|
|updated_at|datatime|null: false|
### Association
- has_many :posts
- has_many :comments

## adressテーブル
|Column|Type|Options|
|------|----|-------|
|prefectures|string|null: false|
|municipalities|string|null: false|
|streetadres|integer|null: false|
|phonenumber|integer|null: false|
|zipcode|integer|null: false|
|send_adress|string|null: false|
### Association
- has_many :posts
- has_many :comments

## productsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|price|integer|null: false|
|image1|string|null: false|
|image2|string|null: false|
|image3|string|null: false|
|brand|string|null: false|
|discription|text|null: false|
|created_at|datatime|null: false|
|updated_at|datatime|null: false|
|user_id|reference|null: false, foreign_key: true|
|category_id|reference|null: false, foreign_key: true|
### Association
- has_many :posts
- has_many :comments

## category_productsテーブル
|Column|Type|Options|
|------|----|-------|
|createded_at|datatime|null: false|
|updated_at|datatime|null: false|
|category_id|integer|null: false, foreign_key: true|
|products_id|integer|null: false, foreign_key: true|
### Association
- has_many :posts
- has_many :comments

## categoryテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|path_length|integer|null: false|
|ancestor_id|integer|null: false, foreign_key: true|
|descendant_id|integer|null: false, foreign_key: true|
|created_id|datatime|null: false, foreign_key: true|
|updated_id|datatime|null: false, foreign_key: true|
### Association
- has_many :posts
- has_many :comments

## buyテーブル
|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
### Association
- has_many :posts
- has_many :comments