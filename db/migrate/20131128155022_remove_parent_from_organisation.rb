class RemoveParentFromOrganisation < ActiveRecord::Migration[6.0]
  def up
    remove_column :organisations, :parent_id
  end

  def down
    add_column :organisations, :parent_id, :integer
  end
end
