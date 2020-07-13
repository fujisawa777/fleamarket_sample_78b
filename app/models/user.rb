class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
  validates :name, presence: true
  validates :password, length: { minimum: 7 }

  has_one :personal, dependent: :destroy
  has_one :sendaddress, dependent: :destroy

  has_many :buyer_products, class_name: 'Product', foreign_key: 'buyer_id'
  has_many :seller_products, class_name: 'Product', foreign_key: 'seller_id'

end
