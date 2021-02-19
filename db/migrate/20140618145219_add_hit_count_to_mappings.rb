class AddHitCountToMappings < ActiveRecord::Migration[6.0]
  def change
    add_column :mappings, :hit_count, :integer
    # add_index :mappings, :hit_count unless index_exists?(:mappings, :hit_count, {})
  end
end
