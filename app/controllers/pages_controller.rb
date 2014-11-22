class PagesController < ApplicationController
  layout 'root', only: %i(root)

  def pricing
  end

  def privacy
    @privacy = MultiJson.load(Net::HTTP.get(URI('http://www.iubenda.com/api/privacy-policy/137049/no-markup')))['content']
  end

  def security
  end

  def changelog
  end

  def root
    if current_user
      redirect_to user_groups_path, notice: 'Welcome back!'
    end

    @user_groups = UserGroup.order('created_at desc').limit(3)
  end
end
