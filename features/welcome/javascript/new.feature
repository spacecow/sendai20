Feature:
Background:
Given I am logged in as member
When I go to the welcome page

@javascript @blank
Scenario: Once opinon cannot be saved blank
And I press "Save Opinion"
Then I should see "Opinion cannot be saved blank." as alert flash message
But I should see no notice flash message
And 0 opinions should exist
And I should be on the welcome page

@javascript @new
Scenario: Create an opinion
And I fill in "My Opinion" with "My own opinion"
And I press "Save Opinion"
Then I should see "Successfully saved opinion." as notice flash message
But I should see no alert flash message
And an opinion should exist with content: "My own opinion", user: that user
And 1 opinions should exist
And I should be on the welcome page
