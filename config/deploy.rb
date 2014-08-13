# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'uglst'
set :repo_url, 'git@github.com:ugtastic/uglst.git'
set :deploy_to, '/var/ugtastic/uglst'
set :linked_files, %w(config/database.yml config/newrelic.yml config/secrets.yml .env)
set :linked_dirs, %w(bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system)
set :rvm_type, :user
set :rvm_ruby_version, 'ruby-2.1.2@uglst'

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

after 'deploy:stop', 'clockwork:stop'
after 'deploy:start', 'clockwork:start'
after 'deploy:restart', 'clockwork:restart'

namespace :clockwork do
  desc 'Stop clockwork'
  task :stop, roles: clockwork_roles, on_error: :continue, on_no_matching_servers: :continue do
    run "if [ -d #{current_path} ] && [ -f #{pid_file} ]; then cd #{current_path} && kill -INT `cat #{pid_file}` ; fi"
  end

  desc 'Start clockwork'
  task :start, roles: clockwork_roles, on_no_matching_servers: :continue do
    run "daemon --inherit --name=clockwork --env='#{rails_env}' --output=#{log_file} --pidfile=#{pid_file} -D #{current_path} -- bundle exec clockwork config/clockwork.rb"
  end

  desc 'Restart clockwork'
  task :restart, roles: clockwork_roles, on_no_matching_servers: :continue do
    stop
    start
  end

  def rails_env
    fetch(:rails_env, false) ? "RAILS_ENV=#{fetch(:rails_env)}" : ''
  end

  def log_file
    fetch(:clockwork_log_file, "#{current_path}/log/clockwork.log")
  end

  def pid_file
    fetch(:clockwork_pid_file, "#{current_path}/tmp/pids/clockwork.pid")
  end
end
