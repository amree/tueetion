class Settings::CreditsController < ApplicationController
  before_action :set_settings_credit, only: [:show, :edit, :update, :destroy]

  # GET /settings/credits
  # GET /settings/credits.json
  def index
    @settings_credits = Settings::Credit.all
  end

  # GET /settings/credits/1
  # GET /settings/credits/1.json
  def show
  end

  # GET /settings/credits/new
  def new
    @settings_credit = Settings::Credit.new
  end

  # GET /settings/credits/1/edit
  def edit
  end

  # POST /settings/credits
  # POST /settings/credits.json
  def create
    @settings_credit = Settings::Credit.new(settings_credit_params)

    respond_to do |format|
      if @settings_credit.save
        format.html { redirect_to @settings_credit, notice: 'Credit was successfully created.' }
        format.json { render action: 'show', status: :created, location: @settings_credit }
      else
        format.html { render action: 'new' }
        format.json { render json: @settings_credit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /settings/credits/1
  # PATCH/PUT /settings/credits/1.json
  def update
    respond_to do |format|
      if @settings_credit.update(settings_credit_params)
        format.html { redirect_to @settings_credit, notice: 'Credit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @settings_credit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /settings/credits/1
  # DELETE /settings/credits/1.json
  def destroy
    @settings_credit.destroy
    respond_to do |format|
      format.html { redirect_to settings_credits_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_settings_credit
      @settings_credit = Settings::Credit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def settings_credit_params
      params.require(:settings_credit).permit(:center_id, :count, :amount, :transaction_number, :payment_method, :paid_at)
    end
end
