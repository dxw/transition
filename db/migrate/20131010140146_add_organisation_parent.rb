class AddOrganisationParent < ActiveRecord::Migration[6.0]
  def change
    add_column :organisations, :parent_id, :integer
  end
end
