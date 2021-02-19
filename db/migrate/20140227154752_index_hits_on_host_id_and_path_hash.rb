class IndexHitsOnHostIdAndPathHash < ActiveRecord::Migration[6.0]
  def change
    add_index :hits, %i[host_id path_hash]
  end
end
