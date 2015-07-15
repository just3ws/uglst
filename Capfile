require 'capistrano/setup'

require 'capistrano/deploy'

require 'capistrano/rvm'
require 'capistrano/bundler'
require 'capistrano/rails'
require 'capistrano/rails/assets'
require 'capistrano/faster_assets'

require 'capistrano/puma'
require 'capistrano/puma/workers' # if you want to control the workers (in cluster mode)
require 'capistrano/puma/jungle' # if you need the jungle tasks
# require 'capistrano/puma/monit' # if you need the monit tasks
require 'capistrano/puma/nginx' # if you want to upload a nginx site template

require 'capistrano/sidekiq'
# require 'capistrano/sidekiq/monit' # to require monit tasks # Only for capistrano3

require 'capistrano/sitemap_generator'

require 'whenever/capistrano'

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
