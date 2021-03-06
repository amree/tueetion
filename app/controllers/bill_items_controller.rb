class BillItemsController < ApplicationController
  before_action :set_bill
  before_action :set_bill_item, only: [:edit, :update, :destroy]

  # GET /bill_items/new
  def new
    @bill_item = @bill.bill_items.new
  end

  # GET /bill_items/1/edit
  def edit
  end

  # POST /bill_items
  # POST /bill_items.json
  def create
    @bill_item = @bill.bill_items.new(bill_item_params)

    respond_to do |format|
      if @bill_item.save
        format.html { redirect_to @bill, notice: 'Bill item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @bill }
      else
        format.html { render action: 'new' }
        format.json { render json: @bill_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bill_items/1
  # PATCH/PUT /bill_items/1.json
  def update
    respond_to do |format|
      if @bill_item.update(bill_item_params)
        format.html { redirect_to @bill, notice: 'Bill item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bill_items/1
  # DELETE /bill_items/1.json
  def destroy
    @bill_item.destroy

    respond_to do |format|
      format.html { redirect_to bill_url(@bill) }
      format.json { head :no_content }
    end
  end

  private

  def set_bill
    @bill = current_center.bills.find(params[:bill_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_bill_item
    @bill_item = @bill.bill_items.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def bill_item_params
    params.require(:bill_item).permit(:name, :amount)
  end
end
