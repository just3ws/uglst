module Uglst
  module Clients
    class Twitter
      attr_accessor :client
      def initialize
        @client = ::Twitter::REST::Client.new do |config|
          config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
          config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
          config.consumer_key        = ENV['TWITTER_API_KEY']
          config.consumer_secret     = ENV['TWITTER_API_SECRET']
        end
      end
    end
  end
end
