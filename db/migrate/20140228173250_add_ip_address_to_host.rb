class AddIpAddressToHost < ActiveRecord::Migration[6.0]
  def change
    add_column :hosts, :ip_address, :string
  end
end
