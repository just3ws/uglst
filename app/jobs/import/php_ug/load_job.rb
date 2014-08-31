module Import
  module PhpUg
    class LoadJob
      include Sidekiq::Worker

      def perform(ug)
        Rails.logger.ap(ug, :info)
        user_group = UserGroup.new(ug)
        user_group.source = Source.friendly.find('php-usergroup')
        user_group.save!
      end
    end
  end
end
