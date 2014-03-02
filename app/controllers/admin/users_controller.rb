class Admin::UsersController < ApplicationController
  before_action :require_admin

  def index
    @users = User.joins(:center).order("users.created_at DESC").to_a
  end

  def show
  end
end
