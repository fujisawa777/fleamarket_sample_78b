class Sendaddress < ApplicationRecord
  belongs_to :user, optional: true

  validates :s_firstname, :s_lastname, :s_h_firstname,
            :s_h_lastname, :zipcode, :prefectures,
            :municipalitities, :streetaddress,
            presence: true

  validates :streetaddress,
            format:{ with: /\A[ぁ-んァ-ン一-龥０-９ａ-ｚA-Z]+\z/ }

  validates :room,
            format:{ with: /\A[ぁ-んァ-ン一-龥０-９ａ-ｚA-Z]+\z/ },
            allow_blank: true

  validates :zipcode, length: { is: 7 }

end