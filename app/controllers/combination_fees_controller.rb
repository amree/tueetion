class CombinationFeesController < ApplicationController
  before_action :set_combination_fee, only: [:show, :edit, :update, :destroy]

  # GET /combination_fees
  # GET /combination_fees.json
  def index
    @combination_fees = current_center.combination_fees.to_a
  end

  # GET /combination_fees/1
  # GET /combination_fees/1.json
  def show
  end

  # GET /combination_fees/new
  def new
    @combination_fee = CombinationFee.new
  end

  # GET /combination_fees/1/edit
  def edit
  end

  # POST /combination_fees
  # POST /combination_fees.json
  def create
    @combination_fee = current_center.combination_fees.new(combination_fee_params)

    respond_to do |format|
      if @combination_fee.save
        format.html { redirect_to @combination_fee, notice: 'Combination fee was successfully created.' }
        format.json { render action: 'show', status: :created, location: @combination_fee }
      else
        format.html { render action: 'new' }
        format.json { render json: @combination_fee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /combination_fees/1
  # PATCH/PUT /combination_fees/1.json
  def update
    respond_to do |format|
      if @combination_fee.update(combination_fee_params)
        format.html { redirect_to @combination_fee, notice: 'Combination fee was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @combination_fee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /combination_fees/1
  # DELETE /combination_fees/1.json
  def destroy
    @combination_fee.destroy
    respond_to do |format|
      format.html { redirect_to combination_fees_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_combination_fee
      @combination_fee = current_center.combination_fees.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def combination_fee_params
      params.require(:combination_fee).permit(:name, :min_subjects, :max_subjects, :price, :is_active)
    end
end
