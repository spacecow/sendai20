Feature:

Scenario: Links within an opinion for a member
Given I am logged in as member
And a user exists with name: "Testy Tester"
And an opinion exists with user: that user
When I go to the welcome page
And I follow "Testy Tester" within the first "opinion" section
Then I should be on that user page

Scenario: View for a user not logged in
Given a user exists with username: "tester", name: "Test User"
And an opinion exists with content: "This is my opinion.", user: that user
When I go to the welcome page
Then I should see "Test User" and "This is my opinion." within the first "opinion" section
But I should see no "my_opinion" section

Scenario: View for a logged in user
Given I am logged in as member
When I go to the welcome page
Then I should see a "my_opinion" section

Scenario: A logged in user should not see his own opinion listed
Given I am logged in as member
And an opinion exists with user: that user, content: "My own opinion"
When I go to the welcome page
Then I should not see "My own opinion" within the "opinions" section
But the "My Opinion" field should contain "My own opinion"

@order
Scenario: Opinions should be ordered after time of update
Given a user exists
And an opinion exists with content: "second", user: that user, updated_at: "2011-4-27 17:12"
And a user exists
And an opinion exists with content: "first", user: that user, updated_at: "2011-4-27 17:11"
When I go to the welcome page
Then I should see "first" within the second "opinion" section

Scenario: Opinions are limited to 10 
Given 11 opinions exist
When I go to the welcome page
Then I should see a tenth "opinion" section
But I should see no eleventh "opinion" section

Scenario: My own opinion is not listed, but opinions should still be 5
Given 4 opinions exist
And I am logged in as member
And a opinion exists with user: that user
And an opinion exist
When I go to the welcome page
Then I should see a fifth "opinion" section
But I should see no sixth "opinion" section
