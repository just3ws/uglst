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
        attr_reader :screen_name, :user_id

        def initialize(args)
          @screen_name, @user_id = if args.is_a?(Hash)
                                     self.class.from_param(args)
                                   else
                                     self.class.from_user_id(args.to_s.downcase.strip)
                                   end
        end

        def self.extract_screen_name_from(input)
          ScreenNameFromString.new(input).screen_name || ScreenNameFromUrl.new(input).screen_name
        end

        def self.lookup_user_id_for(screen_name)
          Uglst::Clients::Twitter.new.client.user(screen_name).id
        end

        def self.lookup_screen_name_for(user_id)
          Uglst::Clients::Twitter.new.client.user(Integer(user_id.to_s)).screen_name
        end

        def self.from_user_id(user_id)
          # Internally we store the user_id
          [
            lookup_screen_name_for(user_id),
            user_id
          ]
        end

        def self.from_param(params = {})
          screen_name = extract_screen_name_from(params[:screen_name])
          user_id     = params[:user_id]

          if user_id.blank? && screen_name.present?
            user_id = lookup_user_id_for(screen_name)
          elsif user_id.present? && screen_name.blank?
            screen_name = lookup_screen_name_for(user_id)
          end

          [
            screen_name,
            user_id
          ]
        end
      end
    end
  end
end
