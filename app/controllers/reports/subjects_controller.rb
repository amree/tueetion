class Reports::SubjectsController < ApplicationController
  before_filter :require_owner

  def index
    @current_year = Time.zone.now.strftime '%Y'
  end
end
