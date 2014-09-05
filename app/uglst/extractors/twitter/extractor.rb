module Uglst
  module Extractors
    module Twitter
      class Extractor
        def self.twitter_client
          ::Twitter::REST::Client.new do |config|
            config.access_token = ENV['TWITTER_ACCESS_TOKEN']
            config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
            config.consumer_key = ENV['TWITTER_API_KEY']
            config.consumer_secret = ENV['TWITTER_API_SECRET']
          end
        end

        def self.parse_screen_name(input)
          input = input.to_s.downcase.strip

          # nil
          # ''
          return nil unless input.present?

          # user_id
          return lookup_screen_name_for(input) if input =~ /^\d+$/

          # @screen_name
          return input.gsub(/^@/, '') if input =~ /^@/

          if input =~ /twitter.com/
            url = if input =~ URI.regexp
                    input
                  else
                    "https://#{input}"
                  end

            ids = IdsPlease.new(url)
            ids.parse

            # .*twitter.com.*/screen_name
            return ids.parsed[:twitter].first
          end

          # screen_name
          input
        end

        def self.lookup_user_id_for(screen_name)
          twitter_client.user(screen_name).id
        end

        def self.lookup_screen_name_for(user_id)
          twitter_client.user(Integer(user_id)).screen_name
        end
      end
    end
  end
end
