# This file is used by Rack-based servers to start the application.
if ENV['RAILS_ENV'] == 'production'
  require 'puma_worker_killer'

  PumaWorkerKiller.config do |config|
    config.ram           = Integer(ENV['PWK_RAM_MB'] || 384)
    config.frequency     = 15 # seconds
    config.percent_usage = 0.98
  end
  PumaWorkerKiller.start
end

require ::File.expand_path('../config/environment', __FILE__)
run Rails.application
