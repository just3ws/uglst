# frozen_string_literal: true
class AutoTweetUserGroupsJob
  include Sidekiq::Worker

  def perform
    ActiveRecord::Base.connection_pool.with_connection do
      user_group_id = UserGroup.unscoped.order('random()').limit(1).first.id

      UserGroupTweeterJob.perform_async(user_group_id)
    end
  rescue => ex
    Rails.logger.error("#{ex.message}\n  #{ex.backtrace.join("\n  ")}")
  end
end
