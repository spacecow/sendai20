Feature:
Background:
Given I am logged in as member
And an opinion exists with content: "This is my opinion.", user: that user
When I go to the root page

Scenario: Once opinon cannot be saved blank
When I fill in "My Opinion" with ""
And I press "Update Opinion"
Then I should see "Opinion cannot be saved blank." as alert flash message
And an opinion should exist with user: that user, content: "This is my opinion."
And 1 opinions should exist
And I should be on the root page

Scenario: Edit opinion view
Then the "My Opinion" field should contain "This is my opinion."
And I should see a "Update Opinion" button

Scenario: Edit an opinion
Given I fill in "My Opinion" with "My second opinion"
And I press "Update Opinion"
Then I should see "Successfully updated opinion." as notice flash message
And an opinion should exist with user: that user, content: "My second opinion"
And an opinion should exist with user: that user, content: "This is my opinion."
And 2 opinions should exist
And I should be on the root page
