# frozen_string_literal: true
class UserGroupsController < ApplicationController
  before_action :set_user_group, only: %i(show edit update destroy join leave)
  before_action :authenticate_user!, only: %i(new edit update destroy join leave)
  after_action :send_tweet!, only: :create

  def send_tweet!
    UserGroupTweeterJob.perform_async(@user_group.id) if @user_group.valid? && @user_group.persisted?
  end

  def index
    query = params[:q]
    @user_groups = if query.present?
                     UserGroup.search_for(query).page(params[:page])
                   else
                     UserGroup.order('created_at').reverse_order.page(params[:page])
                   end

    respond_to do |format|
      format.html { render :index }
      format.rss { render layout: nil }
    end
  end

  def show
    @page_title = "#{@user_group.name} on User-Group List" if @user_group && @user_group.name
    memberships
  end

  def new
    @user_group = current_user.user_groups_registered.build
    @user_group.location = Location.new
  end

  def edit
  end

  def create
    model_params = user_group_params.reject { |key| %w(twitter address).include?(key) }

    @user_group = current_user.user_groups_registered.build(model_params)

    address = user_group_params['address']
    @user_group.location = Location.find_or_create_by(address: address)

    twitter_account_screen_name = user_group_params['twitter']

    if twitter_account_screen_name.blank?
      @user_group.twitter_account = nil
    else
      twitter_account = TwitterAccount.where('screen_name ilike ?', twitter_account_screen_name).first
      @user_group.twitter_account = if twitter_account
                                      twitter_account
                                    else
                                      TwitterAccount.create!(screen_name: twitter_account_screen_name)
                                    end
    end

    respond_to do |format|
      if @user_group.save
        format.html { redirect_to @user_group, notice: 'User-Group was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    unless current_user.admin? || @user_group.registered_by.id == current_user.id
      raise 'You may only update User-Groups that you registered.'
    end

    model_params = user_group_params.reject { |key| %w(twitter address).include?(key) }

    address = user_group_params['address']
    @user_group.location = Location.find_or_create_by(address: address)

    twitter_account_screen_name = user_group_params['twitter']
    if twitter_account_screen_name.blank?
      @user_group.twitter_account = nil
    else
      twitter_account = TwitterAccount.where('screen_name ilike ?', twitter_account_screen_name).first
      @user_group.twitter_account = if twitter_account
                                      twitter_account
                                    else
                                      TwitterAccount.create!(screen_name: twitter_account_screen_name)
                                    end
    end

    respond_to do |format|
      if @user_group.update(model_params)
        format.html { redirect_to @user_group, notice: 'User-Group was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    unless current_user.admin? || @user_group.registered_by.id == current_user.id
      raise 'You may only destroy User-Groups that you registered.'
    end

    @user_group.destroy

    respond_to do |format|
      format.html { redirect_to user_groups_url, notice: 'User-Group was successfully destroyed.' }
    end
  end

  def join
    # 0 == member
    @ugm = UserGroupMembership.create_with(relationship: 0).find_or_create_by(user_id: current_user.id, user_group_id: @user_group.id)
  end

  def leave
    UserGroupMembership.find_by(user_id: current_user.id, user_group_id: @user_group.id, relationship: 0).destroy
  end

  def memberships
    @ugms = UserGroupMembership.includes(:user).where(user_group: @user_group)
  end

  protected

  def set_user_group
    @user_group = UserGroup.friendly.find(params[:id] || params[:user_group_id])
  end

  def user_group_params
    @user_group_params ||= if current_user.admin?
                             params.require(:user_group).permit!
                           else
                             params.require(:user_group).permit(
                               :address,
                               :description,
                               :homepage,
                               :name,
                               :twitter,
                               :topic_list,
                               :logo
                             )
                           end
  end
end
