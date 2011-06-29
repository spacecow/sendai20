Feature:

Scenario: Reset form view
When I go to the new reset page
Then the "Email" field should be empty
And I should see a "Reset Password" button

Scenario: Email must be filled in
When I go to the new reset page
And I fill in "Email" with ""
And I press "Reset Password"
Then I should see a reset email error "can't be blank"

Scenario: The email must already exist in the database
When I go to the new reset page
And I fill in "Email" with "do.not@exist.yet"
And I press "Reset Password"
Then I should see a reset email error "not a registered email"

Scenario: Create a reset
Given a user exists with email: "jsveholm@gmail.com"
When I go to the new reset page
And I fill in "Email" with "jsveholm@gmail.com"
And I press "Reset Password"
Then a reset should exist with user: that user
And 1 resets should exist
And I should be on the root page
And I should see "Instructions of how to reset your password has been sent to your email." as notice flash message
And 1 email should be delivered to jsveholm@gmail.com
