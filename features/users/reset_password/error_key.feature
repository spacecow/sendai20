Feature:
Background:
Given a user exists with email: "example@mail.com"
And a reset exists with email: "example@mail.com"
When I go to that user's change_password page with that reset

Scenario: The new password has to be confirmed
When I fill in "New Password*" with "new_password"
And I press "Update"
Then I should see a user password error "doesn't match confirmation"

Scenario: The new password cannot be blank
When I fill in "New Password*" with ""
And I press "Update"
Then I should see a user password error "can't be blank"
