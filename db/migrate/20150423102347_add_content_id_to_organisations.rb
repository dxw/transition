class AddContentIdToOrganisations < ActiveRecord::Migration[6.0]
  def change
    add_column :organisations, :content_id, :string
  end
end
