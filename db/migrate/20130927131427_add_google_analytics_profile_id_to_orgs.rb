class AddGoogleAnalyticsProfileIdToOrgs < ActiveRecord::Migration[6.0]
  def change
    add_column :organisations, :ga_profile_id, :string, limit: 16
  end
end
