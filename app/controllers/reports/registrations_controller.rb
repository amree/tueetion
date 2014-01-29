class Reports::RegistrationsController < ApplicationController
  def index
    @current_year = Time.zone.now.strftime '%Y'
  end
end
