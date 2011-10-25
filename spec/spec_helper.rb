#encoding: utf-8;
require 'rubygems'

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'factory_girl'
require 'capybara/rspec' 
require 'capybara/rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
Dir[File.expand_path("core/spec/factories/*.rb", Rails.root)].each {|f| require f}
Dir[File.expand_path("auth/spec/factories/*.rb", Rails.root)].each {|f| require f}
#FactoryGirl.find_definitions
ActionMailer::Base.delivery_method = :test
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.default_url_options[:host] = "crm.giftb2b.ru"
RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec
  config.include LoginSpecHelper
 # config.include Lk::Engine.routes.url_helpers
 # config.include Auth::Engine.routes.url_helpers
end

Capybara.default_selector = :css
#Capybara.javascript_driver = :webkit

#Capybara.register_driver :selenium do |app|
#      Capybara::Selenium::Driver.new(app, :browser => :chrome)
#    end




