Rails.application.configure do
  client = Dalli::Client.new(ENV['MEMCACHIER_SERVERS'], value_max_bytes: 10_485_760)

  config.action_controller.perform_caching = true
  config.action_dispatch.rack_cache = true
  config.action_dispatch.rack_cache = { metastore: client, entitystore: client }
  config.active_record.dump_schema_after_migration = false
  config.active_support.deprecation = :notify

  config.assets.cache_store = :dalli_store
  config.assets.compile = true
  config.assets.compress = true
  config.assets.digest = true
  config.assets.js_compressor = :uglifier
  config.assets.version = '1.0'

  config.cache_classes = true
  config.cache_store = :dalli_store
  config.consider_all_requests_local = false
  config.eager_load = true
  config.force_ssl = true
  config.i18n.fallbacks = true
  config.log_formatter = ::Logger::Formatter.new
  config.log_level = :info
  config.serve_static_assets = true
  config.static_cache_control = 'public, max-age=31536000'

  config.action_mailer.default_url_options = { host: 'ugl.st' }
  ActionMailer::Base.smtp_settings = {
    port:           '587',
    address:        'smtp.mandrillapp.com',
    user_name:      ENV['MANDRILL_USERNAME'],
    password:       ENV['MANDRILL_APIKEY'],
    domain:         'heroku.com',
    authentication: :plain
  }
  ActionMailer::Base.delivery_method = :smtp

  config.action_controller.asset_host = Proc.new do |source|
    "//uglst-cdn#{Digest::MD5.hexdigest(source).to_i(16) % 4}.herokuapp.com"
  end

  # config.middleware.use('Rack::Deflater')
  config.middleware.use('Rack::Attack')
  config.middleware.use('PartyFoul::Middleware')
end
