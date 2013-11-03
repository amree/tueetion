class StaffsController < ApplicationController
  def index
    @staffs = current_center.users.where("access_level > 10")
  end
end
