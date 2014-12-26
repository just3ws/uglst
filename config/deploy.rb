# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'uglst'
set :repo_url, 'git@bitbucket.org:ugtastic/ugtastic-public.git'
set :deploy_to, '/var/ugtastic/uglst'
set :linked_files, %w(config/database.yml config/newrelic.yml config/secrets.yml .env)
set :linked_dirs, %w(bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system)
set :rvm_type, :user
set :rvm_ruby_version, 'ruby-2.2.0@uglst'

set :whenever_identifier, -> { "#{fetch(:application)}_#{fetch(:stage)}" }

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end

task :notify_rollbar do
  on roles(:app) do |_h|
    revision = `git log -n 1 --pretty=format:"%H"`
    local_user = `whoami`.gsub(/;$/, '')
    rollbar_token = ENV['ROLLBAR_ACCESS_TOKEN']
    rails_env = fetch(:rails_env, 'production')
    curl_command = "curl -s -o notify_rollbar.log https://api.rollbar.com/api/1/deploy/ -F access_token=#{rollbar_token} -F environment=#{rails_env} -F revision=#{revision} -F local_username=#{local_user}"
    puts curl_command
    execute curl_command, once: true
  end
end
after :deploy, 'notify_rollbar'
