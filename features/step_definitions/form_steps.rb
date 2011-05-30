# Error messages ----------------------
Then /^I should see (?:a|an) (\w+) (\w+) error "([^"]*)"$/ do |mdl,attr,txt|
  page.should have_css("li##{mdl}_#{attr}_input p.inline-errors", :text => txt)
end
Then /^I should see (?:a|an) (\w+) (\w+) error "([^"]*)" on the (\w+) (\w+)/ do |prnt,attr,txt,ordr,chld|
  page.should have_css("li##{prnt}_#{chld.pluralize}_attributes_#{zdigit ordr}_#{attr}_input p.inline-errors", :text => txt)
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

# Selection ----------------------------

Then /^"([^"]*)" should be selected in the "([^"]*)" field$/ do |txt, lbl|
  find_field(lbl).native.xpath("//option[@selected]").inner_html.should eq txt
end
Then /^nothing should be selected in the "([^"]*)" field$/ do |txt, lbl|
  find_field(lbl).native.xpath("//option[@selected]").inner_html.should be_blank
end

# Buttons ------------------------------

When /^I press the button$/ do
   find(:xpath, "//input[@type='submit']").click
end

# Fields -------------------------------

Then /^the "([^"]*)" field should be empty$/ do |lbl|
  field = find_field(lbl)
  if field.tag_name == 'textarea'
    field.text.should == ""
  else
    field.value.should == nil
  end
end
Then /^the (\w+) "([^"]*)" field should be empty$/ do |ordr,lbl|
  Then %(the "#{field_id(lbl,ordr)}" field should be empty)
end
Then /^the (\w+) through (\w+) "([^"]*)" fields? should be empty$/ do |ordr1,ordr2,lbl|
  (zdigit(ordr1)..zdigit(ordr2)).each do |ordr|
    Then %(the "#{field_id(lbl,zword(ordr))}" field should be empty)
  end  
end

Then /^the (\w+) "([^"]*)" field should contain "([^"]*)"$/ do |ordr,lbl,txt|
  Then %(the "#{field_id(lbl,ordr)}" field should contain "#{txt}")
end

When /^I fill in the (\w+) "([^"]*)" with "([^"]*)"$/ do |ordr,lbl,txt|
  When %(I fill in "#{field_id(lbl,ordr)}" with "#{txt}") 
end

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

Then /^I should see no "([^"]*)" field$/ do |txt|
  page.should have_no_css("label", :text => txt)
end

# Functions ----------------------------

def attr_no(prnt,chld,attr,ordr)
  "li##{prnt}_#{chld}_attributes_#{zdigit ordr}_#{attr}_input"
end
def error_no(prnt,chld,attr,ordr)
  "#{attr_no(prnt,chld,attr,ordr)} p.inline-errors"
end
def field_id(lbl,ordr)
  id = find(:css, "label", :text => lbl)[:for]
  id.gsub(/\d/,zdigit(ordr).to_s)
end
