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

require 'webmock/rspec'

require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist

require 'public_activity/testing'

PublicActivity.enabled = false

require 'shoulda-matchers'

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
  config.raise_errors_for_deprecations! if ENV['FAIL_DEPRECATIONS']
end

def record_mode(mode=ENV['VCR_RECORD_MODE'])
  case mode
  when 'all'  then :all
  when 'new'  then :new_episodes
  when 'once' then :once
  else
    :none
  end
end

RSpec::Sidekiq.configure do |config|
  # Clears all job queues before each example
  config.clear_all_enqueued_jobs = true # default => true

  # Warn when jobs are not enqueued to Redis but to a job array
  config.warn_when_jobs_not_processed_by_sidekiq = false
end

WebMock.disable_net_connect!(allow_localhost: true)

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.ignore_localhost                        = true
  c.default_cassette_options                = { record: record_mode }
  c.allow_http_connections_when_no_cassette = false
  c.configure_rspec_metadata!

  c.ignore_hosts 'codeclimate.com'

  filters = []
  # Github
  filters += %w(GITHUB_ADMIN_USER_PASSWORD GITHUB_CLIENT_ID GITHUB_SECRET)

  # LinkedIn
  filters += %w(LINKEDIN_KEY LINKEDIN_SECRET)

  # Mailgun
  filters += %w(MAILGUN_API_KEY MAILGUN_TOKEN)

  # Mixpanel
  filters += %w(MIXPANEL_API_SECRET MIXPANEL_TOKEN)

  # Twitter
  filters += %w(TWITTER_ACCOUNT_ID TWITTER_CONSUMER_KEY TWITTER_CONSUMER_SECRET TWITTER_OAUTH_SECRET TWITTER_OAUTH_TOKEN)

  # Stripe
  filters += %w(STRIPE_PUBLISHABLE_KEY STRIPE_SECRET_KEY)

  # Akismet
  filters += %w(AKISMET_KEY)

  filters.each do |filter|
    c.filter_sensitive_data("<#{filter}>") { ENV[filter] }
  end
end
