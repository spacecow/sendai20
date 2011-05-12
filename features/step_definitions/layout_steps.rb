Then /^I should see "([^"]*)" as (\w+) flash message$/ do |txt,cat|
  Then %(I should see "#{txt}" within "div#flash_#{cat}")
end

Then /^I should see "([^"]*)" as title$/ do |txt|
  Then %(I should see "#{txt}" within "h1")
end

Then /^I should see "([^"]*)" within the (\w+) "([^"]*)" (\w+)$/ do |txt,order,id,cat|
  with_scope(cat_id(cat,id,order)) do
    page.should have_content(txt)
  end
end

Then /^I should see "([^"]*)" within the "([^"]*)" section$/ do |txt,div|
  Then %(I should see "#{txt}" within "div##{underscore div}")
end
Then /^I should not see "([^"]*)" within the "([^"]*)" section$/ do |txt,div|
  Then %(I should not see "#{txt}" within "div##{underscore div}")
end

# AND ----------------------------

Then /^I should see "([^"]*)" and "([^"]*)" within the (\w+) (.+) (\w+)$/ do |txt1,txt2,order,id,cat|
  Then %(I should see "#{txt1}" within the #{order} #{id} #{cat})
  And %(I should see "#{txt2}" within the #{order} #{id} #{cat})
end

# EXISTENCE -------------------

Then /^I should see a (\w+) "([^"]*)" (\w+)$/ do |order,id,cat|
  page.should have_css(cat_id(cat,id,order))
end

Then /^I should see no (\w+) "([^"]*)" (\w+)$/ do |order,id,cat|
  page.should have_no_css(cat_id(cat,id,order))
end

Then /^I should see a "([^"]*)" section$/ do |id|
  page.should have_css("div##{id}")
end

Then /^I should see no "([^"]*)" section$/ do |id|
  page.should have_no_css("div##{id}")
end

Then /^I should see no (\w+) flash message$/ do |cat|
  page.should have_no_css("div#flash_#{cat}")
end

# LINKS -----------------------

When /^I follow "([^"]*)" at the bottom of the page$/ do |lnk|
  When %(I follow "#{lnk}" within the bottom links section)
end

When /^I follow "([^"]*)" within the "([^"]*)" section$/ do |lnk,div|
  When %(I follow "#{lnk}" within "div##{underscore(div)}")
end

When /^I click the image "([^"]*)"$/ do |file|
  find(:xpath, "//a/img[@alt='#{file}']/..").click
end

When /^I follow "([^"]*)" within the (\w+) "([^"]*)" (\w+)$/ do |lnk,order,id,cat|
  When %(I follow "#{lnk}" within "#{cat_id(cat,id,order)}")
end

# FUNCTIONS -------------------

def list_no(lst=nil,order)
  if lst.nil?
    "ul li:nth-child(#{digit order})"
  else
    "ul##{lst} li:nth-child(#{digit order})"
  end
end
def section_no(div=nil,order)
  if div.nil?
    "div:nth-child(#{digit order})"
  else
    "div.#{div}:nth-child(#{digit order})"
  end
end

def cat_id(cat,id,order)
  list_no(id,order) if cat=="listing"
  section_no(id,order) if cat=="section"
end
