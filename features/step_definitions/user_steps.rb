Given /^I am logged in as "([^"]*)"$/ do |email|
  Given %(I go to the root page)
  And %(I fill in "Login" with "#{email}")
  And %(I fill in "Password" with "abc123")
  And %(I press "Login")
end

Given /^I am logged in as #{capture_model}$/ do |mdl|
  Given %(I am logged in as "#{model(mdl).email}")
end

Given /^I am logged in as member$/ do
  Given %(a user exists with roles_mask: 8)
  And %(I am logged in as that user)
end

