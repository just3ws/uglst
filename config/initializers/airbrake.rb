if defined?(Airbrake)
  Airbrake.configure do |config|
    config.api_key = ENV['AIRBRAKE_API']
    config.host = ENV['AIRBRAKE_HOST']
    config.port = 80
    config.secure = config.port == 443
  end
end
