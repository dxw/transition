class AddOrganisationToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :organisation, :string
  end
end
