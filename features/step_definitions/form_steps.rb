# Error messages ----------------------
Then /^I should see (?:a|an) (\w+) (\w+) error "([^"]*)"$/ do |mdl,attr,txt|
  with_scope("li##{mdl}_#{attr}_input p.inline-errors"){ page.text.should eq txt }
end
Then /^I should see (?:a|an) (\w+) (\w+) error: (\w+)$/ do |mdl,attr,err|
  mess = "errors.messages.#{err}"
  Then %(I should see a #{mdl} #{attr} error "#{I18n.t(mess)}")
end
Then /^I should see no (\w+) (\w+) error "([^"]*)"$/ do |mdl,attr,txt|
  page.should have_no_css("li##{mdl}_#{attr}_input p.inline-errors", :text => txt)
end
Then /^I should see no (\w+) (\w+) error: (\w+)$/ do |mdl,attr,err|
  mess = "errors.messages.#{err}"
  Then %(I should see no #{mdl} #{attr} error "#{I18n.t(mess)}")
end

Then /^I should see (?:a|an) (\w+) error "([^"]*)" within the (\w+) (\w+) (\w+) listing$/ do |attr,txt,ordr,prnt,chld|
  with_scope(error_no(prnt,chld,attr,ordr)) do
    page.text.should eq txt
  end
end
Then /^I should see no (\w+) error "([^"]*)" within the (\w+) (\w+) (\w+) listing$/ do |attr,txt,ordr,prnt,chld|
  page.should have_no_css(error_no(prnt,chld,attr,ordr),:text => txt)
end

Then /^I should see a (\w+) (\w+) error$/ do |mdl,attr|
  page.should have_css("li##{mdl}_#{attr}_input p.inline-errors")
end
Then /^I should see no (\w+) (\w+) error$/ do |mdl,attr|
  page.should have_no_css("li##{mdl}_#{attr}_input p.inline-errors")
end

# Fields -------------------------------

When /^I fill in "([^"]*)" with "([^"]*)" within the (.+) section$/ do |fld, txt, div|
  When %(I fill in "#{fld}" with "#{txt}" within "div##{underscore div}")
end

When /^I create (?:a|an) (\w+) with ("[^"]*")((?:, "[^"]*")*)$/ do |mdl, arg1, arg2|
  fields = arg2.split(',')
  fields[0] = arg1
  fields.each do |field|
    field =~ /"(.+):\s*(.+)"/
    When %(I fill in "#{$1}" with "#{$2}")
  end
  And %(I press "Create #{mdl.capitalize}")
end

# Functions ----------------------------

def attr_no(prnt,chld,attr,ordr)
  "li##{prnt}_#{chld}_attributes_#{zdigit ordr}_#{attr}_input"
end
def error_no(prnt,chld,attr,ordr)
  "#{attr_no(prnt,chld,attr,ordr)} p.inline-errors"
end

