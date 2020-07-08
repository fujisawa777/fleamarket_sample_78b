class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to_active_hash :size
  belongs_to_active_hash :status
  belongs_to_active_hash :shipfee
  belongs_to_active_hash :shipregion
  belongs_to_active_hash :estshipdate
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  validates :name, :price, :category_id, :description,
            :status_id, :shipfee_id, :shipregion_id, :estshipdate_id,
            :images, presence: true

end
