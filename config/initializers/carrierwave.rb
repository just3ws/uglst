CarrierWave.configure do |config|
  config.fog_directory = "uglst-#{Rails.env}"
  config.cache_dir = "#{Rails.root}/tmp/uploads"
  config.fog_attributes = { 'Cache-Control' => 'max-age=315576000' }

  if Rails.env.production?
    config.storage = :fog
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
    }
  else
    config.storage = :file
    if Rails.env.test?
      config.enable_processing = false
    end
  end
end
