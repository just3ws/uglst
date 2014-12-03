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

        # Extract screen_name from various inputs
        # - url/name
        # - @name
        # - name
        def self.extract_screen_name_from(input)
          raise "Cannot extract a screen_name from nil." if input.nil?
          raise "Cannot extract a screen_name from a #{input.class.name} expected a String." unless input.is_a?(String)
          raise "Cannot extract a screen_name from a blank string." if input.blank?

          ScreenNameFromString.new(input).screen_name ||
            ScreenNameFromUrl.new(input).screen_name
        end

        def self.lookup_user_id_for(_screen_name)
          _screen_name = _screen_name.to_s.downcase.strip

          ta = TwitterAccount.find_or_create_by(screen_name: _screen_name) do |model|
            data = Uglst::Clients::Twitter.new.client.user(_screen_name)

            model.screen_name = data.screen_name
            model.user_id = Integer(data.id.to_s)

            model.data = data.as_json
          end.reload

          [ ta.screen_name, ta.user_id ]
        end

        def self.lookup_screen_name_for(_user_id)
          _user_id = Integer(_user_id.to_s)

          ta = TwitterAccount.find_or_create_by(user_id: _user_id) do |model|
            data = Uglst::Clients::Twitter.new.client.user(_user_id)

            model.screen_name = data.screen_name
            model.user_id = Integer(data.id.to_s)

            model.data = data.as_json
          end.reload

          [ ta.screen_name, ta.user_id ]
        end

        def self.from_user_id(_user_id)
          # Internally we store the user_id
          [
            lookup_screen_name_for(_user_id).first,
            _user_id
          ]
        end

        def self.from_param(params = {})
          _screen_name = extract_screen_name_from(params[:screen_name])
          _user_id     = params[:user_id]

          if no_user_id_but_has_screen_name?(_user_id, _screen_name)
            lookup_user_id_for(_screen_name)
          elsif has_user_id_but_no_screen_name?(_user_id, _screen_name)
            lookup_screen_name_for(_user_id)
          else
            [
              _screen_name,
              _user_id
            ]
          end
        end

        private

        def self.no_user_id_but_has_screen_name?(_user_id, _screen_name)
          _user_id.blank? && _screen_name.present?
        end

        def self.has_user_id_but_no_screen_name?(_user_id, _screen_name)
          _user_id.present? && _screen_name.blank?
        end
      end
    end
  end
end
