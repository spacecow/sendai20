Feature:
Background:
Given a user exists with password: "abc123"
And I am logged in as that user
When I go to that user's change_password page

Scenario: The old password must be filled in
When I fill in "Old Password" with "wrong"
And I press "Update Password"
Then I should see a user old_password error "doesn't match"

Scenario: The old password is filled in correctly
When I fill in "Old Password" with "abc123"
And I press "Update Password"
Then I should see no user old_password error

Scenario: The new password has to be confirmed
When I fill in "New Password*" with "new_password"
And I press "Update Password"
Then I should see a user password error "doesn't match confirmation"

Scenario: The new password cannot be blank
When I fill in "New Password*" with ""
And I press "Update Password"
Then I should see a user password error "can't be blank"
