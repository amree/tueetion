class CombinationItemFeesController < ApplicationController
  before_action :set_combination_fee
  before_action :set_combination_item_fee, only: [:edit, :update, :destroy]
  before_action :set_subjects_for_select, only: [:new, :create, :edit, :update]

  # GET /combination_item_fees/new
  def new
    @combination_item_fee = CombinationItemFee.new
  end

  # GET /combination_item_fees/1/edit
  def edit
  end

  # POST /combination_item_fees
  # POST /combination_item_fees.json
  def create
    @combination_item_fee = @combination_fee.combination_item_fees.new(combination_item_fee_params)

    respond_to do |format|
      if @combination_item_fee.save
        format.html { redirect_to @combination_fee, notice: 'Combination item fee was successfully created.' }
        format.json { render action: 'show', status: :created, location: @combination_fee }
      else
        format.html { render action: 'new' }
        format.json { render json: @combination_item_fee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /combination_item_fees/1
  # PATCH/PUT /combination_item_fees/1.json
  def update
    respond_to do |format|
      if @combination_item_fee.update(combination_item_fee_params)
        format.html { redirect_to @combination_fee, notice: 'Combination item fee was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @combination_fee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /combination_item_fees/1
  # DELETE /combination_item_fees/1.json
  def destroy
    @combination_item_fee.destroy
    respond_to do |format|
      format.html { redirect_to @combination_fee }
      format.json { head :no_content }
    end
  end

  private
    def set_combination_fee
      @combination_fee = current_center.combination_fees.find(params[:combination_fee_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_combination_item_fee
      @combination_item_fee = @combination_fee.combination_item_fees.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def combination_item_fee_params
      params.require(:combination_item_fee).permit(:combination_fee_id, :subject_id)
    end

    def set_subjects_for_select
      @subjects_for_select = current_center.subjects.to_a.collect { |s| [s.name, s.id] }
    end
end
