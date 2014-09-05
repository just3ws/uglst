ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'

require 'spec_helper'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |c|
  c.fixture_path = "#{::Rails.root}/spec/fixtures"
  c.include Devise::TestHelpers, type: :controller
  c.use_transactional_fixtures = true
end
