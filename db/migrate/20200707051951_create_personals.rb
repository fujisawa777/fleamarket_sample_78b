class CreatePersonals < ActiveRecord::Migration[6.0]
  def change
    create_table :personals do |t|
      t.date       :bithday,            null: false
      t.string     :firstname,          null: false
      t.string     :lastname,           null: false
      t.string     :h_firstname,        null: false
      t.string     :h_lastname,         null: false
      t.string     :description,        null: false
      t.string     :image,              null: false
      t.string     :streetaddress,      null: false
      t.references :user,               foreign_key: true
      t.timestamps
    end
  end
end
