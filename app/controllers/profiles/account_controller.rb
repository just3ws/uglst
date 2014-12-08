module Profiles
  class AccountController < ApplicationController
    include Concerns::Application

    before_action :authenticate_user!, only: %i(edit update)
    before_action :set_profile, only: %i(edit update)
    before_action :set_user, only: %i(edit update)
    before_action :allow_only_self_or_admin, only: %i(edit update)

    def edit
    end

    def update
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to edit_profile_account_path(@profile), notice: 'Your account info was successfully updated.' }
          format.json { render :show, status: :ok, location: edit_profile_account_path(@profile) }
        else
          format.html { render :edit }
          format.json { render json: @profile.errors, status: :unprocessable_entity }
        end
      end
    end

    protected

    def set_profile
      @profile = Profile.find(params[:profile_id])
    end

    def set_user
      @user = current_user
    end

    def user_params
      @user_params ||= if current_user.admin?
                         params.require(:user).permit!
                       else
                         params.require(:user).permit(
                           :email,
                           :username
                         )
                          end
    end
  end
end
