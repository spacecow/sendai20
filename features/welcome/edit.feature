Feature:
Background:
Given I am logged in as member
And an opinion exists with content: "This is my opinion.", user: that user
When I go to the welcome page

Scenario: Once opinon cannot be saved blank
When I fill in "My Opinion" with ""
And I press "Update Opinion"
Then I should see "Opinion cannot be saved blank." as alert flash message
And an opinion should exist with user: that user, content: "This is my opinion."
And 1 opinions should exist
And I should be on the root page

Scenario: Edit an opinion
And I fill in "My Opinion" with "My second opinion"
And I press "Update Opinion"
Then I should see "Successfully updated opinion." as notice flash message
And an opinion should exist with user: that user, content: "My second opinion"
And 1 opinions should exist
And I should be on the root page
