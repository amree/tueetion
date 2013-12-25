class QuantityFeesController < ApplicationController
  before_action :set_quantity_fee, only: [:show, :edit, :update, :destroy]
  before_action :set_subjects_for_select, only: [:new, :create, :edit, :update]

  # GET /quantity_fees
  # GET /quantity_fees.json
  def index
    @quantity_fees = current_center.quantity_fees.to_a
  end

  # GET /quantity_fees/1
  # GET /quantity_fees/1.json
  def show
  end

  # GET /quantity_fees/new
  def new
    @quantity_fee = QuantityFee.new
  end

  # GET /quantity_fees/1/edit
  def edit
  end

  # POST /quantity_fees
  # POST /quantity_fees.json
  def create
    @quantity_fee = current_center.quantity_fees.new(quantity_fee_params)

    respond_to do |format|
      if @quantity_fee.save
        format.html { redirect_to @quantity_fee, notice: 'Quantity fee was successfully created.' }
        format.json { render action: 'show', status: :created, location: @quantity_fee }
      else
        format.html { render action: 'new' }
        format.json { render json: @quantity_fee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quantity_fees/1
  # PATCH/PUT /quantity_fees/1.json
  def update
    respond_to do |format|
      if @quantity_fee.update(quantity_fee_params)
        format.html { redirect_to @quantity_fee, notice: 'Quantity fee was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @quantity_fee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quantity_fees/1
  # DELETE /quantity_fees/1.json
  def destroy
    @quantity_fee.destroy
    respond_to do |format|
      format.html { redirect_to quantity_fees_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quantity_fee
      @quantity_fee = current_center.quantity_fees.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quantity_fee_params
      params.require(:quantity_fee).permit(:subject_id, :name, :price, :is_active)
    end

    def set_subjects_for_select
      @subjects_for_select = current_center.subjects.active.by_name.to_a.collect { |s| [s.name, s.id] }
    end
end
