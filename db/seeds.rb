# We're going to use Factory Girl here to create the the seed data we need when we
# start data testing.
# require Rails.root.join('spec', 'helpers.rb')
require 'factory_girl'
require 'factory_girl_rails'
require 'weekdays'
# require Rails.root.join('spec','factories.rb')
#require 'rubygems'
#seed_data

FactoryGirl.create(:user_with_performances)