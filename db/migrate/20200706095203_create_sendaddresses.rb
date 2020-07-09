class CreateSendaddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :sendaddresses do |t|
      t.string     :s_firstname,        null: false
      t.string     :s_lastname,         null: false
      t.string     :s_h_firstname,      null: false
      t.string     :s_h_lastname,       null: false
      t.integer    :zipcode,            null: false
      t.integer    :prefectures,        null: false
      t.string     :municipalitities,   null: false
      t.string     :streetaddress,      null: false
      t.string     :room
      t.integer    :phonenumber,        null: false
      t.references :user,               foreign_key: true
      t.timestamps
    end
  end
end




