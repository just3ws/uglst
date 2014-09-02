class Domain::Social::TwitterParser
  def self.twitter_client
    Twitter::REST::Client.new do |config|
      config.access_token = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
      config.consumer_key = ENV['TWITTER_API_KEY']
      config.consumer_secret = ENV['TWITTER_API_SECRET']
    end
  end

  def self.parse_screen_name(twitter)
    twitter = twitter.to_s.downcase.strip

    # nil
    # ''
    return nil unless twitter.present?

    # user_id
    return lookup_screen_name_for(Integer(twitter)) if twitter =~ /^\d+$/

    # @screen_name
    return twitter.gsub(/^@/, '') if twitter =~ /^@/

    if twitter =~ /twitter.com/
      _twitter = if twitter =~ URI.regexp
                   twitter
                 else
                   "https://#{twitter}"
                 end

      ids = IdsPlease.new(_twitter)
      ids.parse

      # .*twitter.com.*/screen_name
      return ids.parsed[:twitter].first
    end

    # screen_name
    twitter
  end

  def self.lookup_user_id_for(screen_name)
    twitter_client.user(screen_name).id
  end

  def self.lookup_screen_name_for(user_id)
    twitter_client.user(user_id).screen_name
  end
end
