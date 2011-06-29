Feature:
Background:
Given I am logged in as admin

Scenario: Locales cannot be created blank
When I go to the translations page
And I fill in "Title" with ""
And I press "Create Locale"
Then I should see a locale title error "can't be blank"

Scenario: Locales cannot have their titles duplicated
Given a locale exists with title: "ja"
When I go to the translations page
And I fill in "Title" with "ja"
And I press "Create Locale"
Then I should see a locale title error "has already been taken"

