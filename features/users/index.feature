Feature:

Scenario: Users should be listed in alphabetical order after username
Given a user: "lifter" exists with username: "lifter"
And a user: "dover" exists with username: "dover", roles_mask: 2
And I am logged in as "dover"
When I go to the users page
Then I should see "dover" within the first table row
And I should see "lifter" within the second table row

Scenario Outline: Links within a user for different users
Given a user exists with username: "dover"
And a user exists with roles_mask: <role>, username: "me"
And I am logged in as that user
When I go to the users page
Then I should see links "<links>" within the first table row
Examples:
| role | links                  |
|    2 | Show, Edit, Roles, Del |
|    4 | Show, Edit             |

Scenario: Follow links
Given a user exists with roles_mask: 2
Given I am logged in as that user
When I go to the users page
And I follow "Roles" within the first table row
Then I should be on that user's edit roles page
