Feature:
Background:
Given a user exists with email: "test@example.com", password: "secret"

Scenario: Log in
Given I go to the root page
And I fill in "Login" with "test@example.com"
And I fill in "Password" with "secret"
And I press "Login"
Then I should see "Welcome test@example.com"
And I should be on the root page
