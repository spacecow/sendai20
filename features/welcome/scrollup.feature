Feature:

@order
Scenario: Opinions should be ordered from bottom to top 
Given an opinion exists with content: "second", updated_at: "2011-4-27 17:12"
And an opinion exists with content: "first", updated_at: "2011-4-27 17:11"
When I go to the scrollup page
Then I should see "second" within the second "opinion" section

@limit
Scenario: Opinions are limited to 5
Given 11 opinions exist
When I go to the scrollup page
Then I should see a tenth "opinion" section
But I should see no eleventh "opinion" section
