Feature:

Scenario Outline: Some attributes have restrictions
When I go to the root page
And I press "Sign up"
Then I should be on the users page
And I should see a user <model> error "<message>"
Examples:
|model|message|
|email|is invalid|
|name|can't be blank|
|password|can't be blank|

@signup
Scenario: Sign up view
When I go to the root page
And I fill in "Email" with "some@email.add"
And I fill in "Password*" with "secret"
And I fill in "Password confirmation" with "secret"
And I fill in "City" with "仙台"
And I press "Sign up"
Then a user should exist with address: "仙台"
