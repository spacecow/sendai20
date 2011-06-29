Feature:
Background:
Given a user: "first" exists with email: "example@mail.com"

Scenario: A member cannot reset another member's password
Given I am logged in as user: "first"
And a user: "second" exists
When I go to user: "second"'s change_password page
Then I should be on the welcome page
And I should see "You are not authorized to access this page." as alert flash message

Scenario: A non-logged in user cannot access Reset Password with wrong key
When I go to that user's change_password page with code: "wrongcode"
Then I should be on the welcome page
And I should see "You are not authorized to access this page." as alert flash message

Scenario: A non-logged in user cannot access Reset Password with correct key but wrong user
Given a user: "second" exists with email: "second@mail.com"
And a reset exists with email: "example@mail.com"
When I go to user: "second"'s change_password page with that reset
Then I should be on the welcome page
And I should see "You are not authorized to access this page." as alert flash message

Scenario: A key that aleady have been used cannot be used again
Given a reset exists with status: "used", email: "example@mail.com"
When I go to user: "first"'s change_password page with that reset
Then I should be on the welcome page
And I should see "The key you are trying to use has already been used." as alert flash message

@pending
Scenario: Expiration date
