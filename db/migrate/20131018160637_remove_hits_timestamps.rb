class RemoveHitsTimestamps < ActiveRecord::Migration[6.0]
  def change
    remove_columns :hits, :created_at, :updated_at
  end
end
