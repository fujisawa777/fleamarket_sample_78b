class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :buyer, class_name: 'User', foreign_key: 'buyer_id', optional: true
  belongs_to :seller, class_name: 'User', foreign_key: 'seller_id'
  belongs_to :category, optional: true
  belongs_to_active_hash :size
  belongs_to_active_hash :status
  belongs_to_active_hash :shipfee
  belongs_to_active_hash :shipregion
  belongs_to_active_hash :estshipdate
  has_many :images, dependent: :destroy

  accepts_nested_attributes_for :images, allow_destroy: true

  validates :name, :price, :description,
            presence: { message: "を入力してください"}

  validates :category_id, :status_id, :shipfee_id, :shipregion_id, :estshipdate_id,
            presence: { message: "を選択してください"}

  validates :images, presence: { message: "がありません。"}

  validates :name,    length: { maximum: 40 }

  validates :description,    length: { maximum: 1000 }
end