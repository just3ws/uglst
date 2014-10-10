# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

if ENV['LE_API_KEY'] && Rails.env.development? || Rails.env.production?
  Rails.logger = if Rails.env.development?
                   Le.new(ENV['LE_API_KEY'], debug: true, local: true, tag: true)
                 else
                   Le.new(ENV['LE_API_KEY'], ssl: true, local: true, tag: true)
                 end
end
