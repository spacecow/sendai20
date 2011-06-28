Feature:
Background:
Given a user exists with email: "example@mail.com"
And a reset exists with email: "example@mail.com"
When I go to that user's reset_password page with that reset

Scenario: Update Password
When I fill in "New Password*" with "new_password"
And I fill in "New Password Confirmation" with "new_password"
And I press "Update"
Then I should see "Successfully changed password. You are now logged in." as notice flash message

@pending
Scenario: Update for regular user
