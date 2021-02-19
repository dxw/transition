class AddTitleAndFurlToSite < ActiveRecord::Migration[6.0]
  def change
    add_column :sites, :homepage_title, :string
    add_column :sites, :homepage_furl, :string
  end
end
