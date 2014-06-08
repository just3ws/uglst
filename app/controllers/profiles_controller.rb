class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = if params[:id]
              User.friendly.find(params[:id])
            else
              current_user
            end

    set_map_markers([@user])
  end

  # GET /users/1/edit
  def edit
    @user = current_user
    set_map_markers([@user])
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = current_user

    unless current_user.admin? || @user == current_user
      fail 'You may only update your own account.'
    end

    user_params[:interests] = user_params[:interests].split(',').map(&:strip).compact.sort

    respond_to do |format|
      if @user.update(user_params)
        set_map_markers([@user])
        format.html { redirect_to profile_path(@user), notice: 'Your account was successfully updated.' }
        format.json { render :show, status: :ok, location: profile_path(@user) }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
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

  def set_map_markers(users)
    @markers = Gmaps4rails.build_markers(users) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
      marker.infowindow user.full_name
      marker.title user.full_name
    end
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
        :name,
        :street,
        :city,
        :state_province,
        :country,

        :interests,

        :homepage,
        :twitter,
        :bio,

        :send_stickers
      )
    end
  end
end
