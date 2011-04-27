Feature:
Background:
Given a user exists with name: "Test User", username: "tester", email: "test@example.com"
And I am logged in as that user
When I go to that user's edit page

Scenario: Edit profile view
Then the "Name" field should contain "Test User"
And the "Username" field should contain "tester"
And the "Email" field should contain "test@example.com"

Scenario: Edit profile
When I fill in "Name" with "Another name"
And I press "Update Profile"
Then a user should exist with name: "Another name"
And 1 users should exist
And I should see "Successfully updated profile." as notice flash message
