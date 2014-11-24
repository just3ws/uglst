class PagesController < ApplicationController
  layout 'root', only: %i(root)

  def privacy
    @privacy = MultiJson.load(Net::HTTP.get(URI('http://www.iubenda.com/api/privacy-policy/137049/no-markup')))['content']
  end

  def root
    if current_user
      redirect_to user_groups_path, notice: 'Welcome back!'
    end

    @user_groups = UserGroup.unscoped.order('created_at desc').limit(3)
  end
end
