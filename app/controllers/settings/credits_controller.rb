class Settings::CreditsController < ApplicationController
  before_action :set_credit, only: [:show]

  # GET /settings/credits
  # GET /settings/credits.json
  def index
    @credits = Credit.all
  end

  # GET /settings/credits/1
  # GET /settings/credits/1.json
  def show
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_credit
    @credit = Credit.find(params[:id])
  end
end
