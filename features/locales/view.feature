Feature:
Background:
Given I am logged in as admin

Scenario: Locale form view
When I go to the translations page
Then the "Title" field should be empty
And I should see a "Create Locale" button

#Scenario: Edit locale view
#Given a pair exists with locale: "en", key: "welcome", value: "Welcome!"
#And a locale exists with title: "en"
#When I go to the translations page
#And I follow "Edit Locale" for key "en.welcome"
#Then the "Title" field should contain "en"
#And I should see a "Update Locale" button
