class AddIsRobotToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :is_robot, :boolean, default: false
  end
end
