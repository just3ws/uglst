require 'dotenv'
Dotenv.load

require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |c|
  c.infer_base_class_for_anonymous_controllers = true
  c.order = 'random'
  c.raise_errors_for_deprecations! if ENV['FAIL_DEPRECATIONS']
  c.treat_symbols_as_metadata_keys_with_true_values = true
  c.tty = true
end
