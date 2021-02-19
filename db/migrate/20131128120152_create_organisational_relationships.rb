class CreateOrganisationalRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :organisational_relationships do |t|
      t.integer :parent_organisation_id
      t.integer :child_organisation_id
    end

    add_index :organisational_relationships, :parent_organisation_id
    add_index :organisational_relationships, :child_organisation_id
  end
end
