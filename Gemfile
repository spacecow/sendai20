source 'http://rubygems.org'

gem 'rails', '3.0.5'
gem 'mysql2'
gem 'formtastic' #rails g formtastic:install
gem 'compass' #compass init rails /path/to/myrailsproject --using blueprint/semantic
gem 'cancan' #rails g cancan:ability
gem "bcrypt-ruby", :require => "bcrypt"
gem "mocha", :group => :test
gem "annotate"
gem "forgery"

group :development do
  gem "jquery-rails"
  gem 'nifty-generators', :git => "https://github.com/spacecow/nifty-generators.git"
  gem "rspec-rails" #rails g rspec:install
end

group :test do
  gem 'spork'
  gem 'cucumber-rails' #rails g cucumber:install --capybara --rspec
  gem 'capybara'
  gem 'database_cleaner'
  gem 'pickle' #rails g pickle --paths --email
  gem 'launchy'
  gem 'factory_girl'
  gem 'gherkin'
end
