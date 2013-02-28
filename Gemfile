source 'https://rubygems.org'

gem 'rails', '3.2.12'
gem 'bootstrap-sass', '2.3' # Adds SASS support to Bootstrap
gem 'devise', '2.2.3'     # Authentication system generator
gem 'bcrypt-ruby', '3.0.1' # Adds some security methods
gem 'faker', '1.1.2'       # Not sure what htis does
gem 'will_paginate', '3.0.4'     # Enables "paging" of large numbers of leagues/users
gem 'bootstrap-will_paginate', '0.0.9'  # Enables CSS'ing to the pagination
gem 'jquery-rails', '2.1.3'           # jquery support for rails
gem 'lazy_high_charts'               # plugin for using highcharts
gem 'bundler'

group :development, :test do
  gem 'sqlite3', '1.3.5'      # in case you don't feel like admin'ing a db
  gem 'rspec-rails', '2.11.0'  # for running tests
  # gem 'guard-rspec', '1.2.1'
  # gem 'guard-spork', '1.2.0'
  # gem 'spork', '0.9.2'
end

# Gems used only for assets and not required
# in production environments (by default)
group :assets do
  gem 'sass-rails', '3.2.5'
  gem 'coffee-rails', '3.2.2' # coffeescript, i think
  gem 'uglifier', '1.2.3'     # uglifies javascript
end

group :test do
  gem 'capybara', '1.1.2'     # i think this is  testing library
  gem 'factory_girl_rails', '4.2.1'  # library for generating objects for tests
  gem 'cucumber-rails', '1.3.0', :require => false  # used for BDD
  gem 'database_cleaner', '0.9.1'  # cleans database
  # gem 'launchy', '2.2.0'
  # gem 'rb-fsevent', '0.9.1', :require => false
  # gem 'growl', '1.0.3'
end

group :production do
  gem 'pg', '0.12.2'  # postgresql
end