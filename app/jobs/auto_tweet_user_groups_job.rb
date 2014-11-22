class AutoTweetUserGroupsJob
  include Sidekiq::Worker

  def perform
    ActiveRecord::Base.connection_pool.with_connection do
      user_group_id = UserGroup.unscoped.order('random()').limit(1).first.id

      UserGroupTweeterJob.perform_async(user_group_id)
    end
  rescue => e
    Rails.logger.error e.message + "\n  " + e.backtrace.join("\n  ")
  end
end
