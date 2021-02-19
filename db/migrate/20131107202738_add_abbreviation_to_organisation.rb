class AddAbbreviationToOrganisation < ActiveRecord::Migration[6.0]
  def change
    add_column :organisations, :abbreviation, :string
  end
end
