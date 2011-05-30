Feature:
Background:
Given a user "lifter" exists with email: "lifter@example.com"
And a user "dover" exists with roles_mask: 2, email: "dover@example.com"

@test
Scenario Outline: You must be admin to be able to change user roles
Given a user exists with roles_mask: <role>
And I am logged in as that user
When I go to user: "lifter"'s edit roles page
Then I should <redirect> on user: "lifter"'s edit roles page
Examples:
| role | redirect |
|    2 | be       |
|    4 | not be   |
|    8 | not be   |

Scenario: Update roles
Given I am logged in as "dover@example.com"
When I go to user: "lifter"'s edit roles page
And I uncheck "Admin"
And I check "Mini-admin"
And I check "Member"
And I press "Update Roles"
Then I should see "Successfully updated lifter@example.com's roles." as notice flash message
And a user should exist with email: "lifter@example.com", roles_mask: 12
And I should be on the users page
