class CreateTaggingsIndexOnTypeAndId < ActiveRecord::Migration[6.0]
  def change
    # add_index :taggings, %i[taggable_type taggable_id] unless index_exists?(:mappings_batch_entries, %i[taggable_type taggable_id], {})
  end
end
