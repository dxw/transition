class AddSpecialRedirectStrategyToSite < ActiveRecord::Migration[6.0]
  def change
    add_column :sites, :special_redirect_strategy, :string
  end
end
