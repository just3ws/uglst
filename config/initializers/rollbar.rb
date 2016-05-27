# frozen_string_literal: true
require 'rollbar/rails'

if Rails.env.production?

  Rollbar.configure do |config|
    config.access_token = ENV['ROLLBAR_ACCESS_TOKEN']

    # Here we'll disable in 'test':
    config.enabled = if %w(development test).include?(Rails.env)
                       false
                     else
                       true
                     end

    # Enable asynchronous reporting (uses girl_friday or Threading if girl_friday
    # is not installed)
    # config.use_async = true
    # Supply your own async handler:
    # config.async_handler = Proc.new { |payload|
    #  Thread.new { Rollbar.process_payload(payload) }
    # }

    # Enable asynchronous reporting (using sucker_punch)
    # config.use_sucker_punch

    # Enable delayed reporting (using Sidekiq)
    # config.use_sidekiq
    # You can supply custom Sidekiq options:
    # config.use_sidekiq 'queue' => 'my_queue'
  end
end
