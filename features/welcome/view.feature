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

Scenario: A logged in user should not see his own opinion listed
Given I am logged in as member
And an opinion exists with user: that user, content: "My own opinion"
When I go to the welcome page
Then I should not see "My own opinion" within the opinions listing
But the "My Opinion" field should contain "My own opinion"