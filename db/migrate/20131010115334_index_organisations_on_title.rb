class IndexOrganisationsOnTitle < ActiveRecord::Migration[6.0]
  def change
    add_index :organisations, :title
  end
end
