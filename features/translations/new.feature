Feature:
Background:
Given I am logged in as admin

Scenario: Create a translation
Given a locale exists with title: "en"
When I go to the translations page
And I select "en" from "Locale"
And I fill in "Key" with "welcome"
And I fill in "Value" with "Welcome!"
And I press "Create"
Then a pair should exists with key: "en.welcome", value: "Welcome!"
