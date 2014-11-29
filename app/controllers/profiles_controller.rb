class ProfilesController < ApplicationController
  include Concerns::Application

  before_action :authenticate_user!       , only: %i(update edit destroy)
  before_action :set_user                 , only: %i(update edit destroy show)
  before_action :allow_only_self_or_admin , only: %i(update edit destroy)

  def index
    @users = User.order('created_at').reverse_order.page(params[:page])
  end

  def show
  end

  def edit
  end

  def update
    @resource = if params[:user] then :user
                elsif params[:profile] then :profile
                elsif params[:personal] then :personal
                else
                  fail 'No handler provided for params.'
                end

    #respond_to do |format|
      #if @article.update(article_params)
        #format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        #format.json { render :show, status: :ok, location: @article }
      #else
        #format.html { render :edit }
        #format.json { render json: @article.errors, status: :unprocessable_entity }
      #end
    #end
  end

  def destroy
    unless current_user.admin? || @user == current_user
      fail 'You may only destroy your own account.'
    end

    @user.destroy
    respond_to do |format|
      format.html { redirect_to destroy_user_session_path, notice: 'Your account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  protected

  def set_user
    @user = if params[:id]
              User.friendly.find(params[:id])
            else
              current_user
            end
  end

  def handle_user_updates!
    status = @user.update(user_params)

    {
      errors: @user.errors.full_messages,
      status: status,
      model: @user,
      klass: :user
    }
  end

  def handle_personal_updates!
    status = @user.personal.update(personal_params)

    {
      errors: @user.personal.errors.full_messages,
      status: status,
      model: @user.personal,
      klass: :user
    }
  end

  def handle_profile_updates!
    update_params = profile_params.dup

    status = @user.profile.errors.empty? && @user.profile.update(update_params)

    {
      errors: @user.profile.errors.full_messages,
      status: status,
      model: @user.profile,
      klass: :profile
    }
  end

  def user_params
    if current_user.admin?
      params.require(:user).permit!
    else
      params.require(:user).permit(
        :email,
        :email_opt_in,
        :username
      )
    end
  end
end
