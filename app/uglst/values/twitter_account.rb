module Uglst
  module Values
    class TwitterAccount
      include Comparable

      def self.from_twitter_string(twitter)
        screen_name = Uglst::Extractors::Twitter::Extractor.parse_screen_name(twitter)

        user_id = if screen_name.present?
                    Uglst::Extractors::Twitter::Extractor.lookup_user_id_for(@screen_name)
                  end

        new(screen_name, user_id)
      end

      attr_reader :screen_name

      def initialize(screen_name, user_id = nil)
        @screen_name = screen_name
        @user_id = user_id
      end

      def user_id
        @user_id ||= if screen_name.present?
                       Uglst::Extractors::Twitter::Extractor.lookup_user_id_for(screen_name)
                     end
      end

      delegate :to_s, to: :user_id

      delegate :to_i, to: :user_id

      def <=>(other)
        to_i <=> other.to_i
      end

      delegate :hash, to: :to_i

      def eql?(other)
        to_i == other.to_i
      end
    end
  end
end
