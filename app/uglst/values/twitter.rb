module Uglst
  module Values
    class Twitter
      include Comparable

      def initialize(args)
        extracted = Uglst::Extractors::Twitter::Extractor.new(args)
        ap extracted
        @screen_name = extracted.screen_name
        @user_id = extracted.user_id
      end

      def screen_name
        @screen_name
      end

      def user_id
        @user_id
      end

      delegate :hash, to: :to_i
      delegate :to_i, to: :user_id
      delegate :to_s, to: :user_id

      def <=>(other)
        to_i <=> other.to_i
      end

      def eql?(other)
        to_i == other.to_i
      end
    end
  end
end
