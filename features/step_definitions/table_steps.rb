Then /^I should see "([^"]*)" within the (\w+) table row$/ do |txt,order|
  with_scope("#{table_row order}") do
    page.should have_content(txt)
  end
end
Then /^I should see "([^"]*)" within the (\w+) "([^"]*)" table row$/ do |txt,order,tbl|
  with_scope("#{table_row(tbl,order)}") do
    page.should have_content(txt)
  end
end

Then /^I should not see "([^"]*)" within the (\w+) table row$/ do |txt,order|
  Then %(I should not see "#{txt}" within "#{table_row order}")
end

Then /^I should see no (\w+) "([^"]*)" table row$/ do |order,tbl|
  page.should have_no_css("#{table_row(tbl,order)}")
end

# ------------------ LINKS

When /^I follow "([^"]*)" within the (\w+) table row$/ do |lnk,order|
  When %(I follow "#{lnk}" within "#{table_row order}")
end
When /^I follow "([^"]*)" within the (\w+) "([^"]*)" table row$/ do |lnk,order,tbl|
  When %(I follow "#{lnk}" within "#{table_row(tbl,order)}")
end

Then /^I should see links "([^"]*)" within the (\w+) table row$/ do |lnks,order|
  all("#{table_row order} a").map(&:text).join(", ").should eq lnks
end
Then /^I should see links "([^"]*)" within the (\w+) "([^"]*)" table row$/ do |lnks,order,tbl|
  all("#{table_row(tbl,order)} a").map(&:text).join(", ").should eq lnks
end


def table_row(tbl="",order)
  return "table##{tbl} tr:nth-child(#{digit order})" unless tbl.blank?
  "table tr:nth-child(#{digit order})"
end
