class RemoveIndividualNhsukDomainsFromWhitelist < ActiveRecord::Migration[6.0]
  def up
    WhitelistedHost.where("hostname LIKE '%.nhs.uk'").each(&:destroy)
  end

  def down
    # Nothing here given we don't want to put back domains that don't
    # need to be explicitly whitelisted.
  end
end
