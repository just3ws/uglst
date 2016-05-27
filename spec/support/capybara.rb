# frozen_string_literal: true
require 'capybara'
require 'capybara/rspec'
require 'capybara/poltergeist'

require 'turnip'
require 'turnip/capybara'
require 'turnip/rspec'

require 'capybara-screenshot'
require 'capybara-screenshot/rspec'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(
    app,
    debug: false,
    default_wait_time: 30,
    inspector: false,
    js_errors: false,
    phantomjs_options: %w(--load-images=no --ignore-ssl-errors=yes),
    timeout: 1000
  )
end

Capybara.configure do |c|
  c.default_driver = :poltergeist
  c.default_wait_time = 30
  c.ignore_hidden_elements = false
  c.javascript_driver = :poltergeist
end

Dir[Rails.root.join('spec/acceptance/steps/**/*.rb')].each { |f| require f }

RSpec.configure do |c|
  c.include CommonSteps
  c.include ProfileSteps
  c.include HomepageSteps
  c.include AuthenticationSteps
  c.include UserGroupsSteps
  c.include OpportuntitiesSteps

  c.raise_error_for_unimplemented_steps = true
end
