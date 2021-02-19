class AddOrganisationContentIdToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :organisation_content_id, :string
  end
end
