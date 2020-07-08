class Personal < ApplicationRecord
  belongs_to :user, optional: true

  validates :bithday, :firstname, :lastname, :h_firstname,
            :h_lastname, :description, :image, :streetaddress,
            presence: true

  # validates :firstname, :lastname, :h_firstname, :h_lastname,
  #           if: self.zenkaku?(str)

#def self.zenkaku?(str)
  #return nil if str.nil?
  #unless str.to_s =~/^[^ -~｡-ﾟ]*$/
    #return false
  #end
  #return true
#end

end
