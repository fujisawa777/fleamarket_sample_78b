class Sendaddress < ApplicationRecord
  belongs_to :user, optional: true

  validates :s_firstname, :s_lastname, :s_h_firstname,
            :s_h_lastname, :zipcode, :prefectures,
            :municipalitities, :streetaddress,
            presence: true

  validates :zipcode, length: { is: 7 }

  # validates :s_firstname, :s_lastname, :prefectures, /\A[一-龥]+\z/

  # validates :s_h_firstname, :s_h_lastname, /\A[ァ-ヶー－]+\z/

  # validates :municipalitities, /\A[一-龥ぁ-ん]/

  # validates :room, /\A[ぁ-んァ-ン一-龥]/

  # validates :phonenumber, /\A\d{11}\z/, /\A[0-9]+\z/





#   validates_with :self.zenkaku?(str)
  
#   private

#   def self.zenkaku?(str)
#     return nil if str.nil?
#     unless str.to_s =~/^[^ -~｡-ﾟ]*$/
#       return false
#     end
#     return true
#   end

# end
