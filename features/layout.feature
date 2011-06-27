Feature:

Scenario: Root View
When I go to the root page
Then I should see a "日本語" link within the "user nav" section

Scenario: Root links
When I go to the root page
And I follow "日本語" within the "user nav" section
Then I should see an "English" link within the "user nav" section
