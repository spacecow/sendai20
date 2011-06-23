Feature:
Background:
Given I am logged in as admin

Scenario: Locales cannot be created blank
When I go to the translations page
And I fill in "Title" with ""
And I press "Create Locale"
Then I should see a locale title error "can't be blank"

