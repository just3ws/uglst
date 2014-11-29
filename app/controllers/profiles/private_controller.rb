module Profiles
  class PrivateController < ApplicationController
    def show
    end

    def edit
    end

    def update
    end

    def destroy
    end

    protected

    def personal_params
      if current_user.admin?
        params.require(:personal).permit!
      else
        params.require(:personal).permit(:birthday, :ethnicity, :gender, :parental_status, :race, :relationship_status, :religious_affiliation, :sexual_orientation)
      end
    end
  end
end
