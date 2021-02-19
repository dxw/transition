class DeleteAbsoluteFilenameImportedHitsFiles < ActiveRecord::Migration[6.0]
  def up
    command = "DELETE FROM imported_hits_files WHERE filename LIKE '/%';"
    ActiveRecord::Base.connection.execute(command)
  end

  def down; end
end
