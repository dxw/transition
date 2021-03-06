Feature: Create mappings
  As a GDS user with an interest in mappings,
  I want to create mappings
  so that previously unknown URLs start to send people to the right place

  @javascript
  Scenario:
    Given I have logged in as a GDS Editor
    And there is a site called bis belonging to an organisation bis with these mappings:
      | type     | path | new_url                 |
      | redirect | /r   | http://somewhere.gov.uk |
      | archive  | /a   |                         |
    And I visit the path /sites/bis/mappings
    And I go to create some mappings
    Then I should see "http://bis.gov.uk"
    When I make the new mapping paths "/Needs/Canonicalizing/?q=1, /a, /r, noslash" redirect to www.gov.uk/organisations/bis
    And I continue
    Then the page title should be "Confirm new mappings"
    And I should see options to keep or overwrite the existing mappings
    And I should see the canonicalized paths "/needs/canonicalizing, /a, /r"
    But I should see "/noslash"
    And I should see "/a currently archived"
    And I should see "/r currently redirects to http://somewhere.gov.uk"
    When I save my changes
    Then I should see "2 mappings created" in a modal window
    And I should see a table with 2 saved mappings in the modal
    And I should see "/needs/canonicalizing" in a modal window
    And an automatic analytics event with "bulk-add-redirect-ignore-existing" will fire

  @javascript
  Scenario: Creating a large batch (that will be processed in the background)
    Given I have logged in as a GDS Editor
    And there is a site called bis belonging to an organisation bis with these mappings:
      | type     | path | new_url                 |
      | redirect | /r   | http://somewhere.gov.uk |
      | archive  | /a   |                         |
    And I visit the path /sites/bis/mappings
    And I go to create some mappings
    Then I should see "http://bis.gov.uk"
    When I make 21 new mapping paths redirect to www.gov.uk/organisations/bis
    And I continue
    Then the page title should be "Confirm new mappings"
    When I save my changes
    Then I should see "0 of 21 mappings added" in a modal window
    When I visit the path /sites/bis/mappings
    Then I should not see a modal window
    And I should see a flash message "0 of 21 mappings added"

  @javascript
  Scenario: Creating unresolved mappings
    Given I have logged in as a GDS Editor
    Given there is a site called bis belonging to an organisation bis with these mappings:
      | type       | path |
      | unresolved | /ur0 |
      | unresolved | /ur1 |
    And I visit the path /sites/bis/mappings
    And I go to create some mappings
    Then I should see "http://bis.gov.uk"
    When I make the new mapping paths "/ur2, /ur3" unresolved
    And I continue
    Then the page title should be "Confirm new mappings"
    When I save my changes
    Then I should see a table with 2 saved mappings in the modal

  Scenario: I don't have access
    Given I have logged in as a member of another organisation
    And a site bis exists
    And I visit the path /sites/bis/mappings
    Then I should not see "Add mappings"
    And I visit the path /sites/bis/mappings/bulk_add_batches/new
    Then I should see "You don't have permission to edit mappings for"

  Scenario: Errors shown for invalid inputs
    Given I have logged in as a GDS Editor
    And a site bis exists
    And I visit the path /sites/bis/mappings
    And I go to create some mappings
    When I make the new mapping paths "/" redirect to __INVALID_URL__
    And I continue
    Then I should see "Enter at least one valid path or full URL"
    And I should see a highlighted "Old URLs" label and field
    And the "Old URLs" value should be "/"
    And I should see "Enter a valid URL to redirect to"
    And I should see a highlighted "Redirect to" label and field
    And the "Redirect to" value should be "http://__INVALID_URL__"

  Scenario: Error when trying to redirect to the National Archives
    Given I have logged in as a GDS Editor
    And a site bis exists
    And I visit the path /sites/bis/mappings
    And I go to create some mappings
    And I make the new mapping paths "/archive" redirect to http://webarchive.nationalarchives.gov.uk/archive
    And I continue
    Then I should see "You must use an archive mapping to link to the National Archives, not a redirect"
    And I should see a highlighted "Redirect to" label and field
    And the "Redirect to" value should be "http://webarchive.nationalarchives.gov.uk/archive"
