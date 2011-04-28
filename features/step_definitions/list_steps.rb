Then /^I should see "([^"]*)" within the (\w+) listing$/ do |txt,order|
  with_scope(list_no order) do
    page.should have_content(txt)
  end
end
Then /^I should see "([^"]*)" within the (\w+) "([^"]*)" listing$/ do |txt,order,id|
  Then %(I should see "#{txt}" within the #{order} #{underscore id} listing)
end
Then /^I should see "([^"]*)" within the (\w+) (.+) listing$/ do |txt,order,id|
  with_scope(list_no(id,order)) do
    page.should have_content(txt)
  end
end

Then /^I should not see "([^"]*)" within the (.+) listing$/ do |txt,lst|
  Then %(I should not see "#{txt}" within "ul##{underscore lst}")
end

# AND ----------------------------

Then /^I should see "([^"]*)" and "([^"]*)" within the (\w+) (.+) listing$/ do |txt1,txt2,order,lst|
  Then %(I should see "#{txt1}" within the #{order} #{lst} listing)
  And %(I should see "#{txt2}" within the #{order} #{lst} listing)
end

# LINKS --------------------------

When /^I follow "([^"]*)" within the (\w+) (.+) listing$/ do |lnk,order,lst|
  When %(I follow "#{lnk}" within "#{list_no(lst,order)}")
end

def list_no(lst=nil,order)
  if lst.nil?
    "ul li:nth-child(#{digit order})"
  else
    "ul##{lst} li:nth-child(#{digit order})"
  end
end
