class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to_active_hash :size
  belongs_to_active_hash :status
  belongs_to_active_hash :shipfee
  belongs_to_active_hash :shipregion
  belongs_to_active_hash :estshipdate
end
