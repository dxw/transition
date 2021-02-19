class AddHasAkaToHost < ActiveRecord::Migration[6.0]
  def change
    add_column :hosts, :has_aka, :boolean
  end
end
