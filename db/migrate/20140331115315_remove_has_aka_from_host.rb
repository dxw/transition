class RemoveHasAkaFromHost < ActiveRecord::Migration[6.0]
  def change
    remove_column :hosts, :has_aka
  end
end
