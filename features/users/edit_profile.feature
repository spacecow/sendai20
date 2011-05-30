Feature:
Background:
Given a user exists with name: "Test User", email: "test@example.com", prefecture: "宮城県", address: "Aoba-ku, Katahira"
And I am logged in as that user
When I go to that user's edit page

Scenario: Edit profile view
Then the "Name" field should contain "Test User"
And the "Email" field should contain "test@example.com"
And "宮城県" should be selected in the "Prefecture" field
And the "Address" field should contain "Aoba-ku, Katahira"

Scenario: Edit profile
When I fill in "Name" with "Another name"
And I press "Update Profile"
Then a user should exist with name: "Another name", email: "test@example.com", prefecture: "宮城県", address: "Aoba-ku, Katahira"
And 1 users should exist
And I should see "Successfully updated profile." as notice flash message
