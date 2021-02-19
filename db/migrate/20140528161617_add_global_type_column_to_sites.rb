class AddGlobalTypeColumnToSites < ActiveRecord::Migration[6.0]
  def change
    add_column :sites, :global_type, :string
  end
end
