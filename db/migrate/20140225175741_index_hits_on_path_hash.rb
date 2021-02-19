class IndexHitsOnPathHash < ActiveRecord::Migration[6.0]
  def change
    add_index :hits, :path_hash
  end
end
