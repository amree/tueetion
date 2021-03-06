class Admin::CentersController < ApplicationController
  before_action :require_admin

  # GET /admin/centers
  def index
    @centers = Center.order("created_at DESC").page params[:page]
  end

  # GET /admin/centers/1
  def show
    @center = Center.find(params[:id])
  end
end
