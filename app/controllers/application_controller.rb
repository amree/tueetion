class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :layout_by_resource

  before_filter :authenticate_user!

  protected

  def layout_by_resource
    if devise_controller?
      "single"
    else
      "application"
    end
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

  helper_method :current_center
end
