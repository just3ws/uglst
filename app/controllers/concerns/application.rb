# frozen_string_literal: true
module Concerns
  module Application
    extend ActiveSupport::Concern

    def allow_only_self_or_admin
      raise 'You may only update your own profile.' unless current_user.admin? || @user == current_user
    end
  end
end
