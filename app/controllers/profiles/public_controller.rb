module Profiles
  class PublicController < ApplicationController
    include Concerns::Application

    before_action :authenticate_user!, only: %i(edit update)
    before_action :set_profile, only: %i(edit update)
    before_action :set_user, only: %i(edit update)
    before_action :allow_only_self_or_admin, only: %i(edit update)

    def edit
    end

    def update
      model_params = profile_params.reject { |key| key == 'twitter' }

      twitter_account_screen_name = profile_params['twitter']

      if twitter_account_screen_name.blank?
        @profile.twitter_account = nil
      else
        twitter_account = TwitterAccount.where('screen_name ilike ?', twitter_account_screen_name).first
        @profile.twitter_account = if twitter_account
                                     twitter_account
                                   else
                                     TwitterAccount.create!(screen_name: twitter_account_screen_name)
                                   end
      end

      respond_to do |format|
        if @profile.update(model_params)
          format.html { redirect_to edit_profile_public_path(@profile), notice: 'Your public profile info was successfully updated.' }
          format.json { render :show, status: :ok, location: edit_profile_public_path(@profile) }
        else
          format.html { render :edit }
          format.json { render json: @profile.errors, status: :unprocessable_entity }
        end
      end
    end

    protected

    def set_user
      @user = @profile.user
    end

    def set_profile
      @profile = Profile.find(params[:profile_id])
    end

    def profile_params
      @profile_params ||= if current_user.admin?
                            params.require(:profile).permit!
                          else
                            params.require(:profile).permit(
                              :address,
                              :bio,
                              :first_name,
                              :homepage,
                              :interest_list,
                              :last_name,
                              :twitter
                            )
                          end
    end

    def format_twitter
      return true unless profile_params.key?(:twitter)

      if profile_params[:twitter].present?
        screen_name = profile_params[:twitter].to_s.downcase.strip

        begin
          profile_params[:twitter] = Uglst::Values::Twitter.new(screen_name: screen_name)
        rescue Twitter::Error::NotFound => ex
          @profile.errors.add(:twitter, "screen name '#{screen_name}' was not found.")
          profile_params[:twitter] = nil
        end
      else
        # If the key exists but the value is not present then set the value to nil (as it is probably an empty string).
        profile_params[:twitter] = nil
      end
    end
  end
end
