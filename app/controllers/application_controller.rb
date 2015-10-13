class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :layout_by_resource

  before_filter :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_google_analytics_id
  around_filter :set_time_zone

  protected

  def set_time_zone(&block)
    time_zone = 'Kuala Lumpur'

    if @current_center.present?
      time_zone = @current_center.option.time_zone
    end

    Time.use_zone(time_zone, &block)
  end

  def layout_by_resource
    if devise_controller?
      "single"
    else
      "application"
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :first_name
    devise_parameter_sanitizer.for(:sign_up) << :last_name
    devise_parameter_sanitizer.for(:sign_up) << :key
  end

  def set_google_analytics_id
    if Rails.env.production?
      unless current_user && current_user.is_admin?
        @ga_id = Rails.application.secrets.google_analytics_id
      end
    end
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  private

  def current_center
    @current_center = current_user.try(:center)
  end

  def require_admin
    unless current_user.is_admin?
      redirect_to root_path
    end
  end

  def require_owner
    unless current_user.is_owner?
      redirect_to root_path, alert: 'You do not have sufficient privilege'
    end
  end

  def check_center
    if current_user && current_center.nil?
      redirect_to new_center_path
    end
  end

  helper_method :current_center
end
