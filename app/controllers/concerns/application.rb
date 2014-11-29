module Concerns
  module Application
    extend ActiveSupport::Concern

    def allow_only_self_or_admin
      unless current_user.admin? || @user == current_user
        fail 'You may only update your own profile.'
      end
    end
  end
end
