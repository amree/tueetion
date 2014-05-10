class Admin::CentersController < ApplicationController
  before_action :require_admin

  # GET /admin/centers
  def index
    @centers = Center.all
  end

  # GET /admin/centers/1
  def show
    @center = Center.find(params[:id])
  end
end
