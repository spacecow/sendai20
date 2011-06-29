Feature:

Scenario: Root View
When I go to the root page
Then I should see a "日本語" link within the "user nav" section

Scenario: User nav links
When I go to the root page
And I follow "日本語" within the "user nav" section
Then I should see an "English" link within the "user nav" section

Scenario: Root view for logged in user
Given I am logged in as member
When I go to the root page
Then I should see links "日本語, Edit Profile" within the "user nav" section

Scenario: User nav links for logged in users
Given I am logged in as member
When I go to the root page
And I follow "Edit Profile" within the "user nav" section
Then I should be on that user's edit page
