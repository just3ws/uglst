# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

require 'sitemap_generator/tasks'

task default: %i(spec)
desc 'run Rspec specs'
task :spec do
  sh 'rspec spec'
end

task hello: :environment do
  Rails.logger.info("[#{Time.now}] Hello")
end
