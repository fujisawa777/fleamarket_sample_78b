class Category < ApplicationRecord
    has_many :products
    has_closure_tree

    #validates :name, presence: true, uniqueness: true
end
