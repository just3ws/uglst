ENV['RAILS_ENV'] ||= 'test'

require 'dotenv'
Dotenv.load

require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |c|
  c.fixture_path = "#{::Rails.root}/spec/fixtures"
  c.include Devise::TestHelpers, type: :controller
  c.infer_base_class_for_anonymous_controllers = true
  c.order = 'random'
  c.raise_errors_for_deprecations! if ENV['FAIL_DEPRECATIONS']
  c.treat_symbols_as_metadata_keys_with_true_values = true
  c.tty = true
  c.use_transactional_fixtures = true
end
