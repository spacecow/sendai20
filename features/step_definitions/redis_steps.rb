Given /^a pair exists with locale: "([^"]*)", key: "([^"]*)", value: "([^"]*)"$/ do |locale,key,val|
  I18n.backend.store_translations(locale, {key => val}, :escape => false)
end

When /^I follow "([^"]*)" for key "([^"]*)"$/ do |txt,key|
  find(:css, "tr", :text => key).click_link(txt)
end

Then /^a pair should exists with key: "([^"]*)", value: "([^"]*)"$/ do |key,val|
  $redis[key].should eq "\"#{val}\""
end

Then /^the key "([^"]*)" should not exist$/ do |key|
  $redis[key].should be_nil
end

