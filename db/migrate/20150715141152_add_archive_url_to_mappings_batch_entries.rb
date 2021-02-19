class AddArchiveURLToMappingsBatchEntries < ActiveRecord::Migration[6.0]
  def change
    add_column :mappings_batch_entries, :archive_url, :string
  end
end
