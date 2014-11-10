class UserGroupTweeterJob
  include Sidekiq::Worker

  def perform(user_group_id)
    ActiveRecord::Base.connection_pool.with_connection do
      ug = UserGroup.find(user_group_id)
      send_tweet!(ug) if ug
    end
  rescue => e
    Rails.logger.error e.message + "\n  " + e.backtrace.join("\n  ")
  end

  def send_tweet!(ug)
    client = ::Twitter::REST::Client.new do |config|
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
      config.consumer_key        = ENV['TWITTER_API_KEY']
      config.consumer_secret     = ENV['TWITTER_API_SECRET']
    end

    options = {}
    if ug.latitude && ug.longitude
      options[:lat]                 = ug.latitude.to_f
      options[:long]                = ug.longitude.to_f
      options[:display_coordinates] = true
    end

    # media = File.new(ug.logo.present? ? open("https://ugl.st#{ug.logo.url}") : "#{Rails.root}/app#{ActionController::Base.helpers.asset_path('/assets/images/user_group_avatar_fallback.png', digest: false)}")

    tweet = self.class.tweet(ug)

    # client.update_with_media(tweet, media , options)
    client.update(tweet, options) if Rails.env.production?
  end

  def self.tweet(ug)
    msg = "#{ug.name} #{if ug.twitter.present? then "by @#{ug.twitter.screen_name} " else '' end} #UserGroup #{Rails.application.routes.url_helpers.user_group_url(ug, host: 'ugl.st')} via @uglst"
    msg.gsub(/\s+/, ' ').strip
  end
end
