module Uglst
  module Extractors
    module Twitter
      class ScreenNameFromUrl
        attr_reader :screen_name

        TWITTER_URL_PATTERN = /twitter.com\/([a-zA-Z0-9_]{1,15})/i

        def initialize(input)
          possible_screen_name = input.match(TWITTER_URL_PATTERN).try(:[], 1)
          @screen_name = possible_screen_name unless possible_screen_name.blank?
        end

        delegate :to_s, to: :screen_name
      end
    end
  end
end
