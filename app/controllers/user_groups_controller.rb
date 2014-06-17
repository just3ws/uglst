class UserGroupsController < ApplicationController
  before_action :set_user_group, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]

  # GET /user_groups
  # GET /user_groups.json
  def index
    query        = params[:q]
    @user_groups = if query.present?
                     UserGroup.search_for(query)
                   else
                     UserGroup.all
                   end
  end

  # GET /user_groups/1
  # GET /user_groups/1.json
  def show
  end

  # GET /user_groups/new
  def new
    @user_group = current_user.user_groups_registered.build
  end

  # GET /user_groups/1/edit
  def edit
  end

  # POST /user_groups
  # POST /user_groups.json
  def create
    @user_group = current_user.user_groups_registered.build(user_group_params)

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

  # PATCH/PUT /user_groups/1
  # PATCH/PUT /user_groups/1.json
  def update
    unless current_user.admin? || @user_group.registered_by.id == current_user.id
      fail 'You may only update User-Groups that you registered.'
    end

    # TODO Extract the tag parsing to a before_action
    # TODO Add validation rules around Tags. Maybe it should just be a model relationship?
    update_user_group_params = user_group_params.dup
    update_user_group_params[:topics] = parse_topics_list(update_user_group_params[:topics])

    respond_to do |format|
      if @user_group.update(update_user_group_params)
        format.html { redirect_to @user_group, notice: 'User-Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_group }
      else
        format.html { render :edit }
        format.json { render json: @user_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_groups/1
  # DELETE /user_groups/1.json
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

  private

  def parse_topics_list(topics)
    topics.to_s.split(',').map(&:downcase).map(&:strip).compact.sort.reject { |t| t.blank? }.uniq
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user_group
    @user_group = UserGroup.friendly.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
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
