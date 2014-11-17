ENV['RAILS_ENV'] ||= 'test'

require 'dotenv'
Dotenv.load

require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |c|
  c.infer_base_class_for_anonymous_controllers = true
  c.order = 'random'
  c.raise_errors_for_deprecations! if ENV['FAIL_DEPRECATIONS']
  c.tty = true
  c.fixture_path = "#{::Rails.root}/spec/fixtures"
  c.include Devise::TestHelpers, type: :controller
  c.use_transactional_fixtures = true


  c.around(:each) do |example|
    options = example.metadata[:vcr] || {}
    if options[:record] == :skip
      VCR.turned_off(&example)
    else
      name = example.metadata[:full_description].titleize.gsub(/\W/, '').classify.underscore
      VCR.use_cassette(name, options, &example)
    end
  end
end
