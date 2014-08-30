module Import
  module PhpUg
    class LoadJob
      include Sidekiq::Worker

      def perform(user_group_data)
      end
    end
  end
end
