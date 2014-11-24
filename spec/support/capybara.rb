require 'capybara'
require 'capybara/rspec'
# require 'capybara/poltergeist'

require 'turnip'
require 'turnip/capybara'
require 'turnip/rspec'

require 'capybara-screenshot'
require 'capybara-screenshot/rspec'

# Capybara.register_driver :poltergeist do |app|
# Capybara::Poltergeist::Driver.new(app, {
# js_errors: true,
# default_wait_time: 30,
# timeout: 100,
# inspector: true,
# debug: true,
# phantomjs_options: %w(--load-images=no --ignore-ssl-errors=yes)
# })
# end

Capybara.configure do |c|
  # c.default_driver         = :poltergeist
  # c.javascript_driver      = :poltergeist
  c.ignore_hidden_elements = false
  c.default_wait_time      = 30
end

Dir[Rails.root.join('spec/acceptance/steps/**/*.rb')].each { |f| require f }

RSpec.configure do |c|
  c.include CommonSteps
  c.include ProfileSteps
end
