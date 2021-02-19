class AddSeenOutcomeToMappingsBatch < ActiveRecord::Migration[6.0]
  def change
    add_column :mappings_batches, :seen_outcome, :boolean, default: false
  end
end
