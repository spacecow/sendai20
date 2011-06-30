Feature:
Background:
Given a user exists with email: "example@mail.com", password: "abc123"
And a reset exists with email: "example@mail.com"

Scenario: Update Password with key
When I go to that user's change_password page with that reset
And I fill in "New Password*" with "new_password"
And I fill in "New Password Confirmation" with "new_password"
And I press "Update"
Then I should see "Successfully changed password. You are now logged in." as notice flash message
When I press "Logout"
And I fill in "Login" with "example@mail.com"
And I fill in "Password" with "new_password"
And I press "Login"
Then I should see "Successfully logged in." as notice flash message

Scenario: Update Password for member
Given I am logged in as that user
When I go to that user's change_password page
And I fill in "Old Password" with "abc123"
And I fill in "New Password*" with "new_password"
And I fill in "New Password Confirmation" with "new_password"
And I press "Update Password"
Then I should see "Successfully changed password. You are now logged in." as notice flash message
When I press "Logout"
And I fill in "Login" with "example@mail.com"
And I fill in "Password" with "new_password"
And I press "Login"
Then I should see "Successfully logged in." as notice flash message

Scenario: Reset can only be used once
When I go to that user's change_password page with that reset
And I fill in "New Password*" with "new_password"
And I fill in "New Password Confirmation" with "new_password"
And I press "Update"
Then a reset should exist with status_mask: 1
And 1 resets should exist
