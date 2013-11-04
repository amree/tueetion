class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :layout_by_resource

  before_filter :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

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

  private

  def current_center
    @current_center = current_user.center
  end

  def require_admin
    unless current_user.is_admin
      redirect_to root_path
    end
  end

  def check_center
    if current_user && current_center.nil?
      redirect_to new_center_path
    end
  end

  helper_method :current_center
end
