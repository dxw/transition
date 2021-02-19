class AddCanonicalPathToHostPaths < ActiveRecord::Migration[6.0]
  def change
    add_column :host_paths, :canonical_path, :string, limit: 2048
  end
end
