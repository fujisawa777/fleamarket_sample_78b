class CreatePersonals < ActiveRecord::Migration[6.0]
  def change
    create_table :personals do |t|
      t.date       :birthday,           null: false
      t.string     :firstname,          null: false
      t.string     :lastname,           null: false
      t.string     :h_firstname,        null: false
      t.string     :h_lastname,         null: false
      t.string     :description        
      t.string     :image              
      t.references :user,               foreign_key: true
      t.timestamps
    end
  end
end
