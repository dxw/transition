class AddUniqueIndexToImportedHitsFileFilename < ActiveRecord::Migration[6.0]
  def change
    # add_index :imported_hits_files, :filename, unique: true unless index_exists?(:imported_hits_files, :filename, {unique: true})
  end
end
