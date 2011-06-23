Feature:
Background:
Given I am logged in as admin

Scenario: Edit a translation
Given a pair exists with locale: "en", key: "welcome", value: "Welcome!"
And a locale exists with title: "en"
When I go to the translations page
And I follow "Edit" for key "en.welcome"
Then "en" should be selected in the "Locale" field
And the "Key" field should contain "welcome"
And the "Value" field should contain "Welcome!"
And I should see a "Update Translation" button
