class RemoveManagedByTransitionColumn < ActiveRecord::Migration[6.0]
  def up
    remove_column :sites, :managed_by_transition
  end

  def down
    add_column :sites, :managed_by_transition, :boolean, null: false, default: true
  end
end
