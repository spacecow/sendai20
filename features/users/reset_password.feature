Feature:
Background:
Given a user: "first" exists with email: "example@mail.com"

Scenario: Reset Password View Page for member
Given I am logged in as that user
When I go to that user's reset_password page
Then the "Old Password" field should be empty
And the "New Password" field should be empty
And the "New Password Confirmation" field should be empty

Scenario: Reset Password View Page for user with key
Given a reset exists with email: "example@mail.com"
When I go to that user's reset_password page with that reset
Then I should see no "Old Password" field 
And the "New Password" field should be empty
And the "New Password Confirmation" field should be empty

Scenario: A member cannot reset another member's password
Given I am logged in as user: "first"
And a user: "second" exists
When I go to user: "second"'s reset_password page
Then I should be on the welcome page
And I should see "You are not authorized to access this page." as alert flash message

Scenario: A non-logged in user cannot access Reset Password with wrong key
When I go to that user's reset_password page with code: "wrongcode"
Then I should be on the welcome page
And I should see "You are not authorized to access this page." as alert flash message

Scenario: A non-logged in user cannot access Reset Password with correct key but wrong user
Given a user: "second" exists with email: "second@mail.com"
And a reset exists with email: "example@mail.com"
When I go to user: "second"'s reset_password page with that reset
Then I should be on the welcome page
And I should see "You are not authorized to access this page." as alert flash message
