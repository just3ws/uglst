source 'https://rubygems.org'

ruby '2.2.0'

gem 'rails', '~> 4.2.0'

gem 'coffee-rails'
gem 'sass-rails'

gem 'trailblazer'
gem 'cells'
gem 'cells-haml', github: 'trailblazer/cells-haml'
gem 'rails-timeago'
gem 'fatalistic'

gem 'acts-as-taggable-on', '~> 3.4'
gem 'awesome_print'
gem 'bcrypt', '~> 3.1.7'
gem 'bower-rails'
gem 'carrierwave'
gem 'dalli'
gem 'devise'
gem 'doorkeeper'
gem 'dotenv-deployment'
gem 'dotenv-rails'
gem 'ffaker'
gem 'fog'
gem 'foreman', require: false
gem 'friendly_id'
gem 'geocoder'
gem 'gravatar_image_tag'
gem 'haml-rails'
gem 'hiredis'
gem 'ids_please'
gem 'jbuilder', '~> 2.0'
gem 'kaminari'
gem 'kgio'
gem 'multi_json'
gem 'oj'
gem 'oj_mimic_json'
gem 'paper_trail', '~> 3.0.2'
gem 'pg'
gem 'pg_search'
gem 'pghero'
gem 'pry-rails'
gem 'public_activity', github: 'pokonski/public_activity'
gem 'puma'
gem 'rails_admin', github: 'sferik/rails_admin'
gem 'redis', require: ['redis', 'redis/connection/hiredis']
gem 'reform'
gem 'rest-client'
gem 'sanitize'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'sidekiq'
gem 'simple_form'
gem 'sinatra', '>= 1.3.0', require: false
gem 'sitemap_generator', github: 'kjvarga/sitemap_generator'
gem 'stamp'
gem 'twitter'
gem 'typhoeus'
gem 'uglifier', '>= 1.3.0'
gem 'uuidtools'
gem 'whenever', require: false

group :development do
  gem 'annotate', require: false
  # gem 'better_errors'
  gem 'binding_of_caller'
  gem 'brakeman'
  gem 'bullet'
  gem 'guard-livereload', require: false
  gem 'guard-rspec', require: false
  gem 'rack-livereload'
  gem 'rails-erd'
  gem 'rubocop'
  gem 'spring'
  gem 'spring-commands-rspec'

  gem 'capistrano', '~> 3.2.0'
  gem 'capistrano-bundler', '~> 1.1.3'
  gem 'capistrano-rails', '~> 1.1.1'
  gem 'capistrano-rvm'
  gem 'capistrano3-puma'
  gem 'capistrano-sidekiq'
  gem 'capistrano-faster-assets', '~> 1.0'
  gem 'capistrano-bower'
end

group :development, :test do
  gem 'active_record_query_trace', require: false
  gem 'factory_girl_rails'
  gem 'byebug'
  gem 'jazz_hands', github: 'nixme/jazz_hands', branch: 'bring-your-own-debugger'
  gem 'pry-byebug'
  gem 'quiet_assets'
  gem 'rspec-rails'
  # gem 'web-console', '~> 2.0'
  gem 'zapata'
end

group :test do
  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'codeclimate-test-reporter'
  gem 'database_cleaner'
  gem 'fuubar'
  gem 'poltergeist', require: false
  gem 'rspec-sidekiq'
  gem 'shoulda-matchers', require: false
  gem 'turnip'
  gem 'vcr'
  gem 'webmock'
end

group :production do
  gem 'mandrill-api'
  gem 'newrelic_rpm'
  gem 'rollbar'
end
