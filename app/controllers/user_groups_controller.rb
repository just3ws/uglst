# TODO: Handle automatic saving of fields but with grouping of required fields.
#       For example, first_name and last_name are both required for the same model.
#       Visually group them together in the same section of the form and submit them
#       together in a batch and highlight missing fields and that the form is partially
#       complete.

class UserGroupsController < ApplicationController
  before_action :set_user_group, only: %i(  show edit update destroy join leave  )
  before_action :authenticate_user!, only: %i(  new edit update destroy join leave  )
  after_action :geocode, only: %i(  update create  )
  after_action :send_tweet!, only: :create

  def send_tweet!
    if @user_group.valid? && @user_group.persisted?
      UserGroupTweeterJob.perform_async(@user_group.id)
    end
  end

  def geocode
    if @user_group.valid?
      @user_group.geocode
      @user_group.save!
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
    create_params = user_group_params.dup

    if create_params[:topics].present?
      create_params[:topics] = parse_topics_list(create_params[:topics])
    end

    twitter_errors = nil
    screen_name = create_params.delete(:twitter).to_s.downcase.strip
    begin
      create_params[:twitter] = Uglst::Values::Twitter.new(screen_name: screen_name)
    rescue Twitter::Error::NotFound => ex
      twitter_errors = [:twitter, "screen name '#{screen_name}' was not found."]

      update_params[:twitter] = nil
    end

    @user_group = current_user.user_groups_registered.build(create_params)

    if twitter_errors
      @user_groups.errors.add(*twitter_errors)
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

    update_params = user_group_params.dup

    if update_params[:topics].present?
      update_params[:topics] = parse_topics_list(update_params[:topics])
    end

    twitter_errors = nil
    screen_name = update_params.delete(:twitter).to_s.downcase.strip
    begin
      update_params[:twitter] = Uglst::Values::Twitter.new(screen_name: screen_name)
    rescue Twitter::Error::NotFound => ex
      twitter_errors = [:twitter, "screen name '#{screen_name}' was not found."]

      update_params[:twitter] = nil
    end

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

  private

  def parse_topics_list(topics)
    topics.to_s.split(',').map(&:downcase).map(&:strip).compact.sort.reject(&:blank?).uniq
  end

  def set_user_group
    @user_group = UserGroup.friendly.find(params[:id] || params[:user_group_id])
  end

  def user_group_params
    if current_user.admin?
      params.require(:user_group).permit!
    else
      params.require(:user_group).permit(
        :city,
        :country,
        :description,
        :homepage,
        :name,
        :state_province,
        :twitter,
        :topics,
        :logo
      )
    end
  end
end
