# frozen_string_literal: true

lock '3.4.1'

set :application, 'uglst'
set :repo_url, 'git@github.com:ugtastic/uglst.git'
set :deploy_to, '/var/ugtastic/uglst'
set :linked_files, %w(
  config/database.yml
  config/newrelic.yml
  config/secrets.yml
  .env
)
set :linked_dirs, %w(
  log
  tmp/pids
  tmp/cache
  tmp/sockets
  vendor/bundle
  public/system
)
set :rvm_type, :user
set :rvm_ruby_version, 'ruby-2.3.1@uglst'

set :whenever_identifier, -> { "#{fetch(:application)}_#{fetch(:stage)}" }

task :notify_rollbar do
  on roles(:app) do |_h|
    revision = `git log -n 1 --pretty=format:"%H"`
    local_user = `whoami`.gsub(/;$/, '')
    rollbar_token = ENV['ROLLBAR_ACCESS_TOKEN']
    rails_env = fetch(:rails_env, 'production')
    curl_command = "curl -s -o notify_rollbar.log https://api.rollbar.com/api/1/deploy/ -F access_token=#{rollbar_token} -F environment=#{rails_env} -F revision=#{revision} -F local_username=#{local_user}"
    execute curl_command, once: true
  end
end
after :deploy, 'notify_rollbar'

set :keep_releases, 3
after 'deploy', 'deploy:cleanup'
