class AddMappingAsFkToHits < ActiveRecord::Migration[6.0]
  def change
    add_column :hits, :mapping_id, :integer
    add_index :hits, :mapping_id
  end
end
