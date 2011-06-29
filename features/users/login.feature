Feature:
Background:
Given a user exists with email: "test@example.com", password: "secret"

Scenario: Login
When I go to the root page
And I fill in "Login" with "test@example.com"
And I fill in "Password" with "secret"
And I press "Login"
Then I should see "Welcome test@example.com"
And I should be on the root page

Scenario: Login View
When I go to the root page
Then I should see a "Forgot Password?" link within the "login" form

Scenario: Links in the login section
When I go to the root page
And I follow "Forgot Password?" within the "login" form
Then I should be on the new reset page

Scenario: Wrong login
When I go to the root page
And I fill in "Login" with "some@email.com"
And I fill in "Password" with "wrong"
And I press "Login"
Then I should see "Invalid login or password" as alert flash message
