class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: %i(edit update destroy)

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
    ap params

    @user = current_user

    unless current_user.admin? || @user == current_user
      fail 'You may only update your own profile.'
    end

    # TODO: Send the current value in cases where the value is already set
    result = if params[:user]
               handle_user_updates!
             elsif params[:profile]
               handle_profile_updates!
             elsif params[:personal]
               handle_personal_updates!
             else
               fail 'No handler provided for params.'
             end

    respond_to do |format|
      if result[:status]
        format.json do
          render(json: { status: :success, result[:klass] => result[:model] })
        end
      else
        format.json do
          render(json: result[:errors], status: :unprocessable_entity)
        end
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

    if update_params[:interests].present?
      update_params[:interests] = parse_interests_list(update_params[:interests])
    end

    if update_params[:twitter].present?
      screen_name = update_params.delete(:twitter).to_s.downcase.strip
      begin
        update_params[:twitter] = Uglst::Values::Twitter.new(screen_name: screen_name)
      rescue Twitter::Error::NotFound => ex
        @user.profile.errors.add(:twitter, "screen name '#{screen_name}' was not found.")

        update_params[:twitter] = nil
      end
    end

    status = @user.profile.errors.empty? && @user.profile.update(update_params)

    {
      errors: @user.profile.errors.full_messages,
      status: status,
      model: @user.profile,
      klass: :profile
    }
  end

  def parse_interests_list(interests)
    interests.to_s.split(',').map(&:downcase).map(&:strip).compact.sort.reject(&:blank?).uniq
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = current_user
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def profile_params
    if current_user.admin?
      params.require(:profile).permit!
    else
      params.require(:profile).permit(:address, :bio, :first_name, :homepage, :interests, :last_name, :twitter)
    end
  end

  def personal_params
    if current_user.admin?
      params.require(:personal).permit!
    else
      params.require(:personal).permit(:birthday, :ethnicity, :gender, :parental_status, :race, :relationship_status, :religious_affiliation, :sexual_orientation)
    end
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
