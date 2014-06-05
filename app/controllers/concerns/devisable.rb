module Devisable
  extend ActiveSupport::Concern

  included do
    before_action  :configure_permitted_parameters, if: :devise_controller?
  end

  protected

  def configure_permitted_parameters
    puts " --- configure_permitted_parameters --- "
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(
      :username,
      :email,
      :password,
      :password_confirmation
    ) }
  end
end

DeviseController.send :include, Devisable
