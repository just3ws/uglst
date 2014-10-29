module Uglst
  module Extractors
    module Twitter
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
          screen_name = screen_name.to_s.downcase.strip

          ta = TwitterAccount.find_or_create_by(screen_name: screen_name) do |model|
            data = Uglst::Clients::Twitter.new.client.user(screen_name)

            model.user_id = Integer(data.id.to_s)
            model.data = data.as_json
          end

          ta.user_id
        end

        def self.lookup_screen_name_for(user_id)
          user_id = Integer(user_id.to_s)

          ta = TwitterAccount.find_or_create_by(user_id: user_id) do |model|
            data = Uglst::Clients::Twitter.new.client.user(user_id)

            model.screen_name = data.screen_name
            model.data = data.as_json
          end

          ta.screen_name
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

          if no_user_id_but_has_screen_name?(user_id, screen_name)
            user_id = lookup_user_id_for(screen_name)
          elsif has_user_id_but_no_screen_name?(user_id, screen_name)
            screen_name = lookup_screen_name_for(user_id)
          end

          [
            screen_name,
            user_id
          ]
        end

        private

        def self.no_user_id_but_has_screen_name?(user_id, screen_name)
          user_id.blank? && screen_name.present?
        end

        def self.has_user_id_but_no_screen_name?(user_id, screen_name)
          user_id.present? && screen_name.blank?
        end
      end
    end
  end
end
