Feature:
Background:
Given I am logged in as member
When I go to the welcome page

Scenario: Once opinon cannot be saved blank
And I press "Save Opinion"
Then I should see "Opinion cannot be saved blank." as alert flash message
And 0 opinions should exist
And I should be on the root page

Scenario: Create an opinion
And I fill in "My Opinion" with "My own opinion"
And I press "Save Opinion"
Then an opinion should exist with content: "My own opinion", user: that user
And 1 opinions should exist
And I should see "Successfully saved opinion." as notice flash message
And I should be on the root page
