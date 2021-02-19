class IndexSiteMappingsByPath < ActiveRecord::Migration[6.0]
  def change
    # add_index :mappings, %i[site_id path], unique: true unless index_exists?(:mappings, %i[site_id path], {unique: true})
  end
end
