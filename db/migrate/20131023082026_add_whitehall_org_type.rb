class AddWhitehallOrgType < ActiveRecord::Migration[6.0]
  def change
    add_column :organisations, :whitehall_slug, :string
    add_column :organisations, :whitehall_type, :string
  end
end
