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

Scenario Outline: City address
When I go to the root page
And I fill in everything except address
And I select "<prefecture>" from "Prefecture"
And I fill in "City" with "<city>"
And I fill in "Ward" with "<ward>"
And I press "Sign up"
Then a user should exist with address: "<address>"
Examples:
|prefecture|city|ward|address|
||仙台||仙台|
|||青葉区|青葉区|
||仙台|青葉区|仙台 青葉区|
|宮城県|仙台||宮城県 仙台|
|宮城県||青葉区|宮城県  青葉区|
|宮城県|仙台|青葉区|宮城県 仙台 青葉区|
