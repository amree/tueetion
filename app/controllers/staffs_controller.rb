class StaffsController < ApplicationController
  before_filter :set_staff, only: [:lock, :unlock]

  # GET /staffs
  def index
    @staffs = current_center.users.where("access_level > 10")
  end

  # GET /staffs/1/lock
  def lock
    @staff.is_active = false

    if @staff.save
      redirect_to staffs_url, notice: "Staff was successfully deactivated."
    else
      redirect_to staffs_url, notice: "Staff cannot be deactivated."
    end
  end

  # GET /staffs/1/unlock
  def unlock
    @staff.is_active = true

    if @staff.save
      redirect_to staffs_url, notice: "Staff was successfully activated."
    else
      redirect_to staffs_url, notice: "Staff cannot be activated."
    end
  end

  private

  def set_staff
    @staff = current_center.users.find(params[:id])
  end
end
