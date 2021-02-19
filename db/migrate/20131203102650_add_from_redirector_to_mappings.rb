class AddFromRedirectorToMappings < ActiveRecord::Migration[6.0]
  def change
    add_column :mappings, :from_redirector, :boolean, default: false
  end
end
