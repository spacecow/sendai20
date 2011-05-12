# TEXT --------------------------

Then /^I should see "([^"]*)" within the (\w+) listing$/ do |txt,order|
  with_scope(list_no order) do
    page.should have_content(txt)
  end
end
Then /^I should not see "([^"]*)" within the "([^"]*)" listing$/ do |txt,lst|
  Then %(I should not see "#{txt}" within "ul##{underscore lst}")
end

# LINKS --------------------------

def list_no(lst=nil,order)
  if lst.nil?
    "ul li:nth-child(#{digit order})"
  else
    "ul##{lst} li:nth-child(#{digit order})"
  end
end
  
