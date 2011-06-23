Feature:
Background:
Given I am logged in as admin

Scenario: Delete a translation
Given a pair exists with locale: "en", key: "welcome", value: "Welcome!"
When I go to the translations page
And I follow "Del" for key "en.welcome"
Then the key "en.welcome" should not exist
