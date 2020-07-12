class Sendaddress < ApplicationRecord
  belongs_to :user

  validates :s_firstname, :s_lastname, :s_h_firstname,
            :s_h_lastname, :zipcode, :prefectures,
            :municipalitities, :streetaddress,
            presence: true

  validates :zipcode, length: { is: 7 }
end