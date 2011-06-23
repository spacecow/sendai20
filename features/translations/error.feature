Feature:
Background:
Given I am logged in as admin

Scenario Outline: Key/Value must be filled in
When I go to the translations page
And I fill in "<label>" with ""
And I press "Create"
Then I should see a translation <model> error "can't be blank"
Examples:
| label | model |
| Key   | key   |
| Value | value |

Scenario: Locale must be set
When I go to the translations page
And I select "" from "Locale"
And I press "Create"
Then I should see a translation locale error "can't be blank"
