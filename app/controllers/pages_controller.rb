class PagesController < ApplicationController
  layout 'root', only: %i(root)

  def pricing
  end

  def privacy
  end

  def security
  end

  def changelog
  end

  def root
    if current_user
      redirect_to user_groups_path, notice: 'Welcome back!'
    end
  end
end
