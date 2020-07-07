class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.integer :price, null: false
      t.references :category, null: false
      t.text :description, null: false
      t.string :brand
      t.integer :size_id
      t.integer :status_id, null: false
      t.integer :shipfee_id, null: false
      t.integer :shipregion_id, null: false
      t.integer :estshipdate_id, null: false
      t.references :buyer
      t.references :seller, null: false
      t.boolean :draft, null: false, default: 0
      t.timestamps
    end
  end
end
