class RenameUserOrganisationToOrganisationSlug < ActiveRecord::Migration[6.0]
  def up
    rename_column :users, :organisation, :organisation_slug
  end

  def down
    rename_column :users, :organisation_slug, :organisation
  end
end
