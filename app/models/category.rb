class Category < ApplicationRecord
    has_many :products
    has_closure_tree
end