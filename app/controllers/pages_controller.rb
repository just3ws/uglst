# frozen_string_literal: true
class PagesController < ApplicationController
  layout 'root', only: %i(root)

  def privacy
    @privacy = MultiJson.load(Net::HTTP.get(URI('http://www.iubenda.com/api/privacy-policy/137049/no-markup')))['content']
  end

  def root
    redirect_to user_groups_path, notice: 'Welcome back!' if current_user

    @user_groups = UserGroup.unscoped.order('random()').limit(3)
  end
end
