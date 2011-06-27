Feature:

Scenario: Reset Password View Page
Given I am logged in as member
When I go to that user's reset_password page
Then the "Old Password" field should be empty
And the "New Password" field should be empty
And the "New Password Confirmation" field should be empty
