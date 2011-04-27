Feature:
Background:
Given a user exists with username: "test", password: "secret"

Scenario: Log in
Given I go to the login page
And I fill in "Username" with "test"
And I fill in "Password" with "secret"
And I press "Log in"
Then I should see "Welcome test"
And I should be on the welcome page
