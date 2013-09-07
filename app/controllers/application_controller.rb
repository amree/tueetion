class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate_user!

  def after_sign_in_path_for(resource)
    session[:center_id] = Center.find_by_user_id(current_user.id).try(:id)
    super
  end

  private

  def current_center
    @current_center ||= Center.find_by_id(session[:center_id]) if session[:center_id]
  end
  helper_method :current_center
end
