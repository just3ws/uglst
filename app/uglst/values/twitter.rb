module Uglst
  module Values
    class Twitter
      include Comparable
      attr_reader :screen_name, :user_id

      def initialize(args)
        extracted = Uglst::Extractors::Twitter::Extractor.new(args)
        @screen_name = extracted.screen_name
        @user_id = extracted.user_id
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
