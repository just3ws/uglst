ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'
SimpleCov.start 'rails'

require 'dotenv'
Dotenv.load

require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

require 'database_cleaner'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |c|
  c.include FactoryGirl::Syntax::Methods

  Dir.glob("#{Rails.root}/app/uglst/**/*.rb").each do |f|
    require f
  end

  c.infer_base_class_for_anonymous_controllers = true
  c.order = 'random'
  c.raise_errors_for_deprecations! if ENV['FAIL_DEPRECATIONS']
  c.tty = true

  c.use_transactional_fixtures = true

  c.around(:each) do |example|
    options = example.metadata[:vcr] || {}
    if options[:record] == :skip
      VCR.turned_off(&example)
    else
      name = Digest::MD5.hexdigest(example.metadata[:full_description])
      VCR.use_cassette(name, options, &example)
    end
  end

  c.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  c.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  c.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
    FactoryGirl.reload
  end

  c.before(:each) do
    DatabaseCleaner.start
  end

  c.append_after(:each) do
    DatabaseCleaner.clean
  end
end
