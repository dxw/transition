class CreateImportedHitsFiles < ActiveRecord::Migration[6.0]
  def change
    create_table :imported_hits_files do |t|
      t.string :filename
      t.string :content_hash

      t.timestamps
    end
  end
end
