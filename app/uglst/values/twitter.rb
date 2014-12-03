module Uglst
  module Values
    class Twitter
      include Comparable

      def initialize(args)
        extracted = Uglst::Extractors::Twitter::Extractor.new(args)

        @screen_name = extracted.screen_name
        @user_id = extracted.user_id
      end

      attr_reader :screen_name

      attr_reader :user_id

      delegate :hash, to: :to_i
      delegate :to_i, to: :user_id
      delegate :to_s, to: :screen_name

      def <=>(other)
        to_i <=> other.to_i
      end

      def eql?(other)
        to_i == other.to_i
      end
    end
  end
end
