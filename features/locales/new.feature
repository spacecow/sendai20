Feature:
Background:
Given I am logged in as admin

Scenario: Add a locale
When I go to the translations page
And I fill in "Title" with "en"
And I press "Create Locale"
Then a locale should exist with title: "en"
And 1 locales should exist
And I should see "Successfully created locale." as notice flash message
And I should be on the translations page
