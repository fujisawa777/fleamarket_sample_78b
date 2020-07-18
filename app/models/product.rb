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

  validates :name, :description,
            presence: { message: "を入力してください"}
  validates :category_id, :status_id, :shipfee_id, :shipregion_id, :estshipdate_id,
            presence: { message: "を選択してください"}
  validates :images, presence: { message: "がありません。"}
  validates :name,    length: { maximum: 40 }
  validates :description,    length: { maximum: 1000 }
  validates :price,   numericality: { only_integer: true , greater_than_or_equal_to: 300 , less_than_or_equal_to: 9999999, message: "は300円から9999999円以内にしてください"}
  validate  :category_id_validation

  def category_id_validation
    parents = Category.roots.ids
    children = Category.find_all_by_generation(1).ids

    parents.each do |parent|
      if category_id == parent
        errors.add(:category_id, "を選択してください")
      else
        children.each do |child|
          if category_id == child
            errors.add(:category_id, "を選択してください")
          end
        end
      end
    end
  end
end