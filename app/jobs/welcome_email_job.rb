class WelcomeEmailJob
  include SuckerPunch::Job

  def perform(user_id)
    ActiveRecord::Base.connection_pool.with_connection do
      ap user_id
      user = User.find(user_id)
      ap user
    end
  end
end
