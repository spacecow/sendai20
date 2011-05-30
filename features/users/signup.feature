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

Scenario: Signing up
When I go to the root page
And I fill in "Name" with "Some Name"
And I fill in "Email" with "some@email.add"
And I fill in "Password*" with "secret"
And I fill in "Password confirmation" with "secret"
And I select "宮城県" from "Prefecture"
And I fill in "Address" with "青葉区"
And I press "Sign up"
Then a user should exist with name: "Some Name", email: "some@email.add", address: "青葉区", prefecture: "宮城県" 
