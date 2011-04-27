Then /^I should see "([^"]*)" as (\w+) flash message$/ do |txt,cat|
  Then %(I should see "#{txt}" within "div#flash_#{cat}")
end

Then /^I should see "([^"]*)" as title$/ do |txt|
  Then %(I should see "#{txt}" within "h1")
end

Then /^I should see "([^"]*)" within the (.+) section$/ do |txt,div|
  Then %(I should see "#{txt}" within "div##{underscore div}")
end
Then /^I should not see "([^"]*)" within the (.+) section$/ do |txt,div|
  Then %(I should not see "#{txt}" within "div##{underscore div}")
end

Then /^I should see a "([^"]*)" section$/ do |div|
  page.should have_css("div##{div}")
end
Then /^I should see no "([^"]*)" section$/ do |div|
  page.should have_no_css("div##{div}")
end

