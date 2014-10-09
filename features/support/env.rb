ENV['RAILS_ENV'] ||= 'test'
ENV['GUARD_ENV'] ||= 'test'

require 'dotenv'
Dotenv.load

require 'cucumber/rails'

require 'capybara'
require 'capybara/cucumber'
require 'capybara/poltergeist'

require 'rspec'

Capybara.default_driver = :poltergeist
Capybara.register_driver :poltergeist do |app|
  options = {
    js_errors: true,
    timeout: 120,
    debug: false,
    phantomjs_options: %w(--load-images=no --disk-cache=false),
    inspector: true
  }
  Capybara::Poltergeist::Driver.new(app, options)
end

Capybara.javascript_driver = :poltergeist

ActionController::Base.allow_rescue = false

begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise 'You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it.'
end

Cucumber::Rails::Database.javascript_strategy = :truncation
