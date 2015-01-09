# TODO: Handle automatic saving of fields but with grouping of required fields.
#       For example, first_name and last_name are both required for the same model.
#       Visually group them together in the same section of the form and submit them
#       together in a batch and highlight missing fields and that the form is partially
#       complete.

class UserGroupsController < ApplicationController
  include Twitterable
  before_action(only: %i(create update)) do |c|
    c.format_twitter(user_group_params)
  end

  before_action :set_user_group, only: %i(show edit update destroy join leave)
  before_action :authenticate_user!, only: %i(new edit update destroy join leave)
  after_action :send_tweet!, only: :create

  def send_tweet!
    if @user_group.valid? && @user_group.persisted?
      UserGroupTweeterJob.perform_async(@user_group.id)
    end
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
  end

  def edit
  end

  def create
    create_params = user_group_params

    begin
      @user_group = current_user.user_groups_registered.build(create_params)
    rescue => ex
      ap ex
    end

    respond_to do |format|
      if @user_group.save
        format.html { redirect_to @user_group, notice: 'User-Group was successfully created.' }
        format.json { render :show, status: :created, location: @user_group }
      else
        format.html { render :new }
        format.json { render json: @user_group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    unless current_user.admin? || @user_group.registered_by.id == current_user.id
      fail 'You may only update User-Groups that you registered.'
    end

    update_params = user_group_params

    respond_to do |format|
      if @user_group.update(update_params)
        format.html { redirect_to @user_group, notice: 'User-Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_group }
      else
        format.html { render :edit }
        format.json { render json: @user_group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    unless current_user.admin? || @user_group.registered_by.id == current_user.id
      fail 'You may only destroy User-Groups that you registered.'
    end

    @user_group.destroy
    respond_to do |format|
      format.html { redirect_to user_groups_url, notice: 'User-Group was successfully destroyed.' }
      format.json { head :no_content }
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
                               :city,
                               :country,
                               :description,
                               :homepage,
                               :name,
                               :state_province,
                               :twitter,
                               :topic_list,
                               :logo
                             )
                           end
  end
end
