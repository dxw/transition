class IndexOrganisationsOnWhitehallSlug < ActiveRecord::Migration[6.0]
  def change
    add_index :organisations, :whitehall_slug, unique: true
  end
end
