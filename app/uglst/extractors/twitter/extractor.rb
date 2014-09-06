module Uglst
  module Extractors
    module Twitter
      class ScreenNameFromUrl
        attr_reader :screen_name
        def initialize(input)
          possible_screen_name = input.match(/twitter.com\/([a-zA-Z0-9]{1,15})/i).try(:[], 1)
          @screen_name = possible_screen_name unless possible_screen_name.blank?
        end
        delegate :to_s, to: :screen_name
      end

      class ScreenNameFromString
        attr_reader :screen_name
        def initialize(input)
          @screen_name = input.gsub(/^@/, '') if input =~ /^@?([a-zA-Z0-9_]){1,15}$/i
        end
        delegate :to_s, to: :screen_name
      end

      class Extractor
        attr_reader :value

        def initialize(input)
          input = input.to_s.downcase.strip

          @value = ScreenNameFromString.new(input).screen_name ||
            ScreenNameFromUrl.new(input).screen_name
        end

        def self.lookup_user_id_for(screen_name)
          Uglst::Clients::Twitter.new.client.user(screen_name).id
        end

        def self.lookup_screen_name_for(user_id)
          Uglst::Clients::Twitter.new.client.user(Integer(user_id.to_s)).screen_name
        end
      end
    end
  end
end
