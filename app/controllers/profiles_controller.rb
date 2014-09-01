class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: %i(  edit update destroy  )

  def index
    @users = User.order('created_at').reverse_order
  end

  def show
    @user = if params[:id]
              User.friendly.find(params[:id])
            else
              current_user
            end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    unless current_user.admin? || @user == current_user
      fail 'You may only update your own account.'
    end

    update_user_params = user_params.dup

    # TODO Extract the tag parsing to a before_action
    # TODO Add validation rules around Tags. Maybe it should just be a model relationship?
    update_user_params[:profile_attributes][:interests] = parse_interests_list(update_user_params[:profile_attributes][:interests])

    respond_to do |format|
      if @user.update!(update_user_params)
        format.html { redirect_to profile_path(@user), notice: 'Your account was successfully updated.' }
        format.json { render :show, status: :ok, location: profile_path(@user) }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = current_user

    unless current_user.admin? || @user == current_user
      fail 'You may only destroy your own account.'
    end

    @user.destroy
    respond_to do |format|
      format.html { redirect_to destroy_user_session_path, notice: 'Your account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def parse_interests_list(interests)
    interests.to_s.split(',').map(&:downcase).map(&:strip).compact.sort.reject { |i| i.blank? }.uniq
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = current_user
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    if current_user.admin?
      params.require(:user).permit!
    else
      params.require(:user).permit(
          :email,
          :email_opt_in,
          :username,
          profile_attributes: %i(id address bio first_name homepage interests last_name twitter),
          personal_attributes: %i(id birthday ethnicity gender parental_status race relationship_status religious_affiliation sexual_orientation)
      )
    end
  end
end
