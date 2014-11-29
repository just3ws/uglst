class ProfilesController < ApplicationController
  include Concerns::Application

  before_action :set_user, only: :show

  def index
    @users = User.order('created_at').reverse_order.page(params[:page])
  end

  def show
  end

  protected

  def set_user
    @user = if params[:id]
              User.friendly.find(params[:id])
            else
              current_user
            end
  end
end
