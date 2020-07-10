class Personal < ApplicationRecord
  belongs_to :user, optional: true

  validates :birthday, :firstname, :lastname,
            :h_firstname, :h_lastname,
            presence: true

  validates :firstname, :lastname, :h_firstname, :h_lastname,
            format:{ with: /\A[ぁ-んァ-ン一-龥]/ }

# 振り仮名はカタカナだけオッケーにするバリデーションかける
end
