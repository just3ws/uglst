require 'uuidtools'

class ApplicationController < ActionController::Base
  include Pundit
  include PublicActivity::StoreController

  before_action :log_metrics

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

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

  # Ke#eping user on the same page after signing out
  # def after_sign_out_path_for(_resource_or_scope)
  # if request.referrer
  # request.referrer
  # end
  # end

  def log_metrics
    xff = request.headers['X-Forwarded-For'] || ''
    requestor_ip = xff.split(/, ?/)[0] || request.ip

    filters = Rails.application.config.filter_parameters
    f = ActionDispatch::Http::ParameterFilter.new(filters)

    Metric.create(
      session_id:           unless session.nil? && session[:session_id].nil? then session[:session_id] else nil end,
        request_controller:   request.params[:controller],
        request_action:       request.params[:action],
        request_ip:           request.ip,
        request_xff:          xff,
        request_requestor_ip: requestor_ip,
        request_referrer:     request.referrer,
        request_url:          request.url,
        request_method:       request.method.to_s,
        request_params:       MultiJson.dump(f.filter(request.params)),
        user_id:              unless current_user.nil? then current_user.id else nil end,
        request_user_agent:   request.env['HTTP_USER_AGENT']
    )

  rescue => ex
    Rails.logger.error("Metrics insertion failed with error: #{ex.message}\n  #{ex.backtrace.join("\n  ")}")
  end

  def send_welcome_email
    WelcomeEmailJob.perform_async(@user.id) if @user.valid? && @user.persisted?
  end
end
