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
|prefecture|can't be blank|
|address|can't be blank|

Scenario: A map should be shown on the error page
When I go to the root page
And I press "Sign up"
Then I should see an image within the "new_user" form

Scenario: A map should be shown once even if everything is filled out correctly
When I go to the root page
And I fill in "Name" with "Some Name"
And I fill in "Email" with "some@email.add"
And I fill in "Password*" with "secret"
And I fill in "Password confirmation" with "secret"
And I select "宮城県" from "Prefecture"
And I fill in "Address" with "青葉区"
And I press "Sign up"
Then I should see an image within the "new_user" form
And 0 users should exist
And I should see no notice flash message

Scenario: Signing up
When I go to the root page
And I fill in "Name" with "Some Name"
And I fill in "Email" with "some@email.add"
And I fill in "Password*" with "secret"
And I fill in "Password confirmation" with "secret"
And I select "宮城県" from "Prefecture"
And I fill in "Address" with "青葉区"
And I press "Sign up"
When I press "Sign up"
Then a user should exist with name: "Some Name", email: "some@email.add", address: "青葉区", prefecture: "宮城県" 
And 1 users should exist
And I should see "Thank you for signing up! You are now logged in." as notice flash message
