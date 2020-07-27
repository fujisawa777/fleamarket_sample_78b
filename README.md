<p align = "center"><img src = "https://user-images.githubusercontent.com/65913824/88502195-b1d40780-d008-11ea-99a6-a298a05408a2.png"></img></P>

<h2 align = "center">ECサイト【FURIMA】</h2>

<p align = "center">
  <a href="https://www.ruby-lang.org/ja/"> <img src = "https://user-images.githubusercontent.com/65913824/88496678-eb9d1200-cff8-11ea-89f5-665b8a754233.png" width="100px;" /></img></a>
  <a href="https://rubyonrails.org/"> <img src = "https://user-images.githubusercontent.com/65913824/88496679-ecce3f00-cff8-11ea-9255-e9329756ad8e.png" width="100px;" /></img></a>
  <a href="https://jquery.com/"> <img src = "https://user-images.githubusercontent.com/65913824/88506711-8277c780-d015-11ea-9c91-bbc06d30665f.png" width="100px;" /></img></a>
  <a href="https://www.mysql.com/jp/"> <img src = "https://user-images.githubusercontent.com/65913824/88507447-6543f880-d017-11ea-9d7e-847376235ea9.png" width="100px;" /></img></a>
  <a href="https://github.com"> <img src = "https://user-images.githubusercontent.com/65913824/88507445-6543f880-d017-11ea-8149-cee4c8d67f71.png" width="100px;" /></img></a>
  <a href="https://aws.amazon.com/jp/"> <img src = "https://user-images.githubusercontent.com/65913824/88506712-83a8f480-d015-11ea-8b4d-0833139d4b9f.png" width="100px;" /></img></a>
  <a href="https://azure.microsoft.com/ja-jp/products/visual-studio-code/"> <img src = "https://user-images.githubusercontent.com/65913824/88507443-637a3500-d017-11ea-958d-92c808655618.png" width="100px;" /></img></a>
</p>
<br>

<p align="center"><br>
<b><a>- Contributors -</a></b><br><br>
<b><a><a href="https://github.com/yoyoyonoyo"><img src="https://avatars0.githubusercontent.com/u/65913824" width="70px;" style="border-radius: 50%;" /></a></b>
<b><a><a href="https://github.com/fujisawa777"><img src="https://avatars2.githubusercontent.com/u/66346129" width="70px;" /></a></b>
<b><a><a href="https://github.com/myshy5ne"><img src="" width="70px;" /></a></b>
<b><a><a href="https://github.com/athlaliel"><img src="https://avatars1.githubusercontent.com/u/66309248" width="70px;" /></a></b>
<b><a><a href="https://github.com/saki10"><img src="https://avatars2.githubusercontent.com/u/66323139" width="70px;" /></a></b>
</p>
<br>

## 📖アプリ概要
  某プログラミングスクールの最終課題にて作成したメルカリのようなフリーマーケットアプリケーションです。基本的な機能は実装完了しておりますが、飛べないリンク等ございますのでご了承ください。<br>
  <br>
  また、デプロイも実施済みですがAWSの課金等を考慮して公開しておりません。<br>
  もし、お使いになる場合はローカル環境にコピーしてお使いください。<br>

## 💻開発環境
- Ruby 2.6.5
- Ruby on Rails 6.0.3.2
- jQuery
- MySQL 0.5.3 (DB)
- Github
- AWS
- Visual Studio Code

## 💬使い方（ローカル環境）
1. 下記コードの実行
```
$ cd "インストールしたいディレクトリ"
$ git clone https://github.com/fujisawa777/fleamarket_sample_78b.git
$ bundle install
$ yarn install
$ rails db:create
$ rails db:migrate
$ rails db:seed
$ rails s
```
2. ブラウザでアクセス
http://localhost:3000

### **注意点**
- ローカル環境で実行する場合、上記で記載した開発環境と同じ環境が必要となります。
- ローカル環境にコピーした場合、クレジットカード登録機能及びクレジットカード購入機能は使えません。

## 📦実装機能
- 商品一覧機能
- 商品詳細機能
- 商品出品&編集&削除機能
- カテゴリ登録機能
- 商品購入機能
- ユーザ新規登録&ログイン機能




## ライセンス





## アプリ詳細

## 📕DB設計

### usersテーブル
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

### Personalsテーブル
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

### Creditcardsテーブル
|Column|Type|Options|
|------|----|-------|
|customer_id|string|null: false,unique: true|
|token|string||
|user_id|references|null: false,foreign_key: true|
|update_at|timestamp|null: false|
|created_at|timestamp|null: false|
### Association
- belongs_to: user


### Favoritesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false,foreign_key: true|
|products_id|references|null: false,foreign_key: true|
|created_id|timestamp|null: false|
|updated_id|timestamp|null: false|
### Association
- belongs_to: user
- belongs_to: product

### Commentsテーブル
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


### SnsCredentialsテーブル
|Column|Type|Options|
|------|----|-------|
|provider|string|null: false|
|uid|string|null: false,unique: true|
|token|string||
|user_id|references|null: false,foreign_key: true|
### Association
- belongs_to: user

### SendAddressesテーブル
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

### productsテーブル
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

### Evaluationsテーブル
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


### EvaluationNamesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many: evaluations

### Imagesテーブル
|Column|Type|Options|
|------|----|-------|
|url|string|null: false|
|created_id|timestamp|null: false|
|updated_id|timestamp|null: false|
|product_id|integer|null: false,foreign_key: true|
### Association
- belongs_to: product

### Categoryテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|parent_id|integer||
|created_id|timestamp|null: false|
|updated_id|timestamp|null: false|
### Association
- has_many: products
- has_closure_tree

### Burandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many: products

### Sizes テーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many: products

### Statues テーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many: products

### Shipfees テーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many: products

### Shipreagons テーブル
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