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
    @errors = []

    # TODO: Handle attributes targeted to the User object as well as to the Profile object

    @user = current_user

    unless current_user.admin? || @user == current_user
      fail 'You may only update your own account.'
    end

    update_profile_params = profile_params.dup

    if update_profile_params[:interests].present?
      puts 'Reformat the Interests attribute'
      update_profile_params[:interests] = parse_interests_list(update_profile_params[:interests])
    end

    if update_profile_params[:twitter].present?
      puts 'Reformat the Twitter attribute'
      screen_name = update_profile_params.delete(:twitter).to_s.downcase.strip
      begin
        update_profile_params[:twitter] = Uglst::Values::Twitter.new(screen_name: screen_name)
      rescue Twitter::Error::NotFound => ex
        @user.profile.errors.add(:twitter, "screen name '#{screen_name}' was not found.")

        update_profile_params[:twitter] = nil
      end
    end

    respond_to do |format|
      if @user.profile.errors.empty? && @user.profile.update!(update_profile_params)
        format.json do
          render(json: {status: :success, profile: @user.profile})
        end
      else
        format.json do
          render(json: @user.profile.errors.full_messages, status: :unprocessable_entity)
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
