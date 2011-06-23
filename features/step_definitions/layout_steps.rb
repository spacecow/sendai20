# TEXT -------------------------

Then /^I should see "([^"]*)" as (\w+) flash message$/ do |txt,cat|
  Then %(I should see "#{txt}" within "div#flash_#{cat}")
end

Then /^I should see "([^"]*)" as title$/ do |txt|
  Then %(I should see "#{txt}" within "h1")
end

# AND ----------------------------

Then /^I should see "([^"]*)" and "([^"]*)"$/ do |txt1,txt2|
  Then %(I should see "#{txt1}")
  And %(I should see "#{txt2}")
end
Then /^I should see "([^"]*)" but not "([^"]*)"$/ do |txt1,txt2|
  Then %(I should see "#{txt1}")
  And %(I should not see "#{txt2}")
end

# ACTIVE ----------------------

Then /^the (?:menu|submenu) "([^"]*)" should be active$/ do |menu|
  page.should have_css(".active", :text => menu)
end
Then /^the (?:menu|submenu) "([^"]*)" should be inactive$/ do |menu|
  page.should have_no_css(".active", :text => menu)
end

# EXISTENCE -------------------

Then /^I should see a (\w+) "([^"]*)" (\w+)$/ do |order,id,cat|
  page.should have_css(cat_id(cat,id,order))
end
Then /^I should see a (\w+) through (\w+) "([^"]*)" (\w+)$/ do |ordr1,ordr2,id,cat|
  (zdigit(ordr1)..zdigit(ordr2)).each do |ordr|
    page.should have_css(cat_id(cat,id,zword(ordr)))
  end  
end

Then /^I should see no (\w+) "([^"]*)" (\w+)$/ do |order,id,cat|
  page.should have_no_css(cat_id(cat,id,order))
end

Then /^I should see (?:a|an) "([^"]*)" (section|form)$/ do |id,cat|
  if cat=="section"
    page.should have_css("div##{id}")
  elsif cat=="form"
    page.should have_css("form##{id}")
  end 
end
Then /^I should see no "([^"]*)" (section|form)$/ do |id,cat|
  if cat=="section"
    page.should have_no_css("div##{id}")
  elsif cat=="form"
    page.should have_no_css("form##{id}")
  end 
end

Then /^I should see no (\w+) flash message$/ do |cat|
  page.should have_no_css("div#flash_#{cat}")
end

Then /^I should see no links at the bottom of the page$/ do
  page.should have_no_css("div#bottom_links a")
end

Then /^I should see (?:a|an) "([^"]*)" image$/ do |alt|
  page.should have_xpath("//img[@alt='#{alt}']")
end
Then /^I should see no "([^"]*)" image$/ do |alt|
  page.should have_no_xpath("//img[@alt='#{alt}']")
end

Then /^I should see an image$/ do
  page.should have_css("img")
end
Then /^I should see no image$/ do
  page.should have_no_css("img")
end

# LINKS -----------------------

Then /^I should see (?:a|an) "([^"]*)" link$/ do |lnk|
  page.should have_css("a", :text => lnk)
end
Then /^I should see no "([^"]*)" link$/ do |lnk|
  page.should have_no_css("a", :text => lnk)
end

Then /^I should see a "([^"]*)" image link$/ do |lnk|
  page.should have_css("a img", :alt => lnk)
end
Then /^I should see no "([^"]*)" image link$/ do |lnk|
  page.should have_no_css("a img", :alt => lnk)
end

Then /^I should see links "([^"]*)"$/ do |lnks|
  all("a").map(&:text).join(", ").should eq lnks
end

Then /^I should see links "([^"]*)" at the (\w+) of the page$/ do |lnks,pos|
  Then %(I should see links "#{lnks}" within the "#{pos}_links" section)
end

When /^I follow "([^"]*)" at the bottom of the page$/ do |lnk|
  When %(I follow "#{lnk}" within the "bottom links" section)
end

When /^I click the image "([^"]*)"$/ do |file|
  find(:xpath, "//a/img[@alt='#{file}']/..").click
end
