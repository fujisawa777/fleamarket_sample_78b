class AddProductIdToImage < ActiveRecord::Migration[6.0]
  def change
    add_reference :images, :product, null: false, foreign_key: true
  end
end
