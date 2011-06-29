Feature:
Background:
Given a user: "first" exists with email: "example@mail.com"

Scenario: Reset Password View Page for member
Given I am logged in as that user
When I go to that user's change_password page
Then the "Old Password" field should be empty
And the "New Password" field should be empty
And the "New Password Confirmation" field should be empty
And I should see a "Update" button

Scenario: Reset Password View Page for user with key
Given a reset exists with email: "example@mail.com"
When I go to that user's change_password page with that reset
Then I should see no "Old Password" field 
And the "New Password" field should be empty
And the "New Password Confirmation" field should be empty

