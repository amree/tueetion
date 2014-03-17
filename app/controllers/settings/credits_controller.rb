class Settings::CreditsController < ApplicationController
  before_action :set_credit, only: [:show]

  # GET /settings/credits
  def index
    @credits = current_center.credits
  end

  # GET /settings/credits/1
  def show
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_credit
    @credit = Credit.find(params[:id])
  end
end
