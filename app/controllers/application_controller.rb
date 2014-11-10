require 'metrics_hash'
require 'uuidtools'

class ApplicationController < ActionController::Base
  include PublicActivity::StoreController

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(
        :username,
        :email,
        :password,
        :password_confirmation
      )
    end
  end

  # Redirect to a specific page on successful sign in and sign out
  def after_sign_in_path_for(_resource)
    session.fetch('user_return_to', user_groups_path)
  end

  # Keeping user on the same page after signing out
  def after_sign_out_path_for(_resource_or_scope)
    request.referrer
  end

  def log_metrics
    xff = request.headers['X-Forwarded-For'] || ''
    requestor_ip = xff.split(/, ?/)[0] || request.ip

    metrics = MetricsHash.new
    metrics['request_controller'] = request.params[:controller]
    metrics['request_action'] = request.params[:action]
    metrics['request_ip'] = request.ip
    metrics['request_xff'] = xff
    metrics['request_requestor_ip'] = requestor_ip
    metrics['request_url'] = request.url
    metrics['request_method'] = request.method.to_s

    yield

    # output metrics that were stored in logger.metrics[]
    logger.info { metrics.to_s }
  end

  def send_welcome_email
    WelcomeEmailJob.perform_async(@user.id) if @user.valid? && @user.persisted?
  end
end
