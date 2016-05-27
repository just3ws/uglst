# frozen_string_literal: true
module Import
  module PhpUg
    class LoadJob
      include Sidekiq::Worker

      def perform(remote_id, user_group_data)
        Import::Data::PhpUg.find_by(id: remote_id).update_attribute(:state, 'load')

        Rails.logger.ap(user_group_data, :info)
        user_group = UserGroup.new(user_group_data)
        user_group.source = Source.friendly.find('php-usergroup')
        user_group.save!
      end
    end
  end
end
