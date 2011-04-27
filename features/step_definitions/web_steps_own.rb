Then /^I should not be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path.should_not == path_to(page_name)
end
