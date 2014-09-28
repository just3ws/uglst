# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

Rails.logger = if Rails.env.development?
                 Le.new('a8bcd1d4-c027-4270-b797-48f5ff93ae0d', debug: true, local: true, tag: true)
               else
                 Le.new('a8bcd1d4-c027-4270-b797-48f5ff93ae0d', ssl: true, local: true, tag: true)
               end
