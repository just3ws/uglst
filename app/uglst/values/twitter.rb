module Uglst
  module Values
    class Twitter
      include Comparable
      attr_reader :screen_name, :user_id

      def initialize(args)
        @screen_name, @user_id = if args.is_a?(Hash)
                                   self.class.from_param(args)
                                 else
                                   self.class.from_user_id(args)
                                 end
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

      def self.from_user_id(user_id)
        # Internally we store the user_id
        [
          Uglst::Extractors::Twitter::Extractor.lookup_screen_name_for(user_id),
          user_id
        ]
      end

      def self.from_param(params = {})
        screen_name = Uglst::Extractors::Twitter::Extractor.extract_screen_name_from(params[:screen_name])
        user_id     = params[:user_id]

        if user_id.blank? && screen_name.present?
          user_id = Uglst::Extractors::Twitter::Extractor.lookup_user_id_for(screen_name)
        elsif user_id.present? && screen_name.blank?
          screen_name = Uglst::Extractors::Twitter::Extractor.lookup_screen_name_for(user_id)
        end

        [
          screen_name,
          user_id
        ]
      end

    end
  end
end
