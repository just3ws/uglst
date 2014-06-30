ENV['RAILS_ENV'] ||= 'test'
require 'dotenv'
Dotenv.load

require 'simplecov'
SimpleCov.start 'rails'

require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'

require 'bitfields/rspec'

require 'sucker_punch/testing/inline'

require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist

require 'public_activity/testing'

PublicActivity.enabled = false

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.include Devise::TestHelpers, type: :controller
  config.infer_base_class_for_anonymous_controllers = true
  config.order                                      = 'random'
  config.tty                                        = true
  config.use_transactional_fixtures                 = true
  config.mock_with :rspec do |mocks|

    # This option should be set when all dependencies are being loaded
    # before a spec run, as is the case in a typical spec helper. It will
    # cause any verifying double instantiation for a class that does not
    # exist to raise, protecting against incorrectly spelt names.
    mocks.verify_doubled_constant_names = true

  end
end
