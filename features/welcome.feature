Feature:

Scenario: View for a user not logged in
Given a user exists with name: "Test User"
And an opinion exists with content: "This is my opinion.", user: that user
When I go to the welcome page
Then I should see "Test User: This is my opinion." within the first opinions listing
But I should see no "my_opinion" section

Scenario: View for a logged in user
Given I am logged in as member
When I go to the welcome page
Then I should see a "my_opinion" section

Scenario: Create an opinion
Given I am logged in as member
When I go to the welcome page
And I fill in "My Opinion" with "My own opinion"
And I press "Save Opinion"
Then an opinion should exist with content: "My own opinion", user: that user
And 1 opinions should exist
And I should see "Successfully saved opinion." as notice flash message
And I should be on the welcome page

Scenario: A logged in user should not see his own opinion listed
Given I am logged in as member
And an opinion exists with user: that user, content: "My own opinion"
When I go to the welcome page
Then I should not see "My own opinion" within the opinions listing
But the "My Opinion" field should contain "My own opinion"

@javascript
Scenario: Edit an opinion
Given I am logged in as member
And an opinion exists with content: "This is my opinion.", user: that user
When I go to the welcome page
And I fill in "My Opinion" with "My second opinion"
And I press "Update Opinion"
Then I should see "Successfully updated opinion." as notice flash message
And an opinion should exist with user: that user, content: "My second opinion"
And 1 opinions should exist
And I should be on the welcome page

