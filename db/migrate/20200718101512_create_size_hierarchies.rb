class CreateSizeHierarchies < ActiveRecord::Migration[6.0]
  def change
    create_table :size_hierarchies, id: false do |t|
      t.integer :ancestor_id, null: false
      t.integer :descendant_id, null: false
      t.integer :generations, null: false
    end

    add_index :size_hierarchies, [:ancestor_id, :descendant_id, :generations],
      unique: true,
      name: "size_anc_desc_idx"

    add_index :size_hierarchies, [:descendant_id],
      name: "size_desc_idx"
  end
end
