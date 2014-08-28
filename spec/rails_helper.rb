ENV['RAILS_ENV'] ||= 'test'

require 'dotenv'
Dotenv.load

require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.include Devise::TestHelpers, type: :controller
  config.infer_base_class_for_anonymous_controllers = true
  config.order                                      = 'random'
  config.tty                                        = true
  config.use_transactional_fixtures                 = true
  config.raise_errors_for_deprecations! if ENV['FAIL_DEPRECATIONS']
end
