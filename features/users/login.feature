Feature:
Background:
Given a user exists with username: "test", password: "secret"

Scenario: Log in
Given I go to the root page
And I fill in "Email" with "test"
And I fill in "Password" with "secret"
And I press "Login"
Then I should see "Welcome test"
And I should be on the welcome page
