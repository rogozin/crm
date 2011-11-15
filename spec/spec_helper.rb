#encoding: utf-8;
require 'rubygems'

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'factory_girl'
require 'capybara/rspec' 
require 'capybara/rails'
require 'authlogic/test_case'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
Dir[File.expand_path("../gift/core/spec/factories/*.rb", Rails.root)].each {|f| require f}
Dir[File.expand_path("../gift/auth/spec/factories/*.rb", Rails.root)].each {|f| require f}
FactoryGirl.find_definitions
ActionMailer::Base.delivery_method = :test
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.default_url_options[:host] = "crm.giftb2b.ru"
RSpec.configure do |config|  
  config.mock_with :rspec
  config.include Authlogic::TestCase
  config.include LoginSpecHelper
end

Capybara.default_selector = :css
#Capybara.javascript_driver = :webkit

#Capybara.register_driver :selenium do |app|
#      Capybara::Selenium::Driver.new(app, :browser => :chrome)
#    end




