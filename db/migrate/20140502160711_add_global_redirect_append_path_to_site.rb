class AddGlobalRedirectAppendPathToSite < ActiveRecord::Migration[6.0]
  def change
    add_column :sites, :global_redirect_append_path, :boolean, default: false, null: false
  end
end
