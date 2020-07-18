class AddParentIdToSize < ActiveRecord::Migration[6.0]
  def change
    add_column :sizes, :parent_id, :integer
  end
end
