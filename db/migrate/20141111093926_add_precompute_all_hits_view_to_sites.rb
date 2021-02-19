class AddPrecomputeAllHitsViewToSites < ActiveRecord::Migration[6.0]
  def change
    add_column :sites,
               :precompute_all_hits_view, :boolean,
               null: false,
               default: false
  end
end
