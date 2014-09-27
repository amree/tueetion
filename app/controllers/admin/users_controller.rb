class Admin::UsersController < ApplicationController
  before_action :require_admin

  def index
    @users = User.joins(:center).order("users.created_at DESC").page params[:page]
  end

  def show
  end
end
