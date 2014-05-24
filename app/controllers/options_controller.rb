class OptionsController < ApplicationController
  before_action :set_option

  # GET /options/1/edit
  def edit
  end

  # PATCH/PUT /options/1
  def update
    if @option.update(option_params)
      redirect_to edit_option_path(@option), notice: 'Options was successfully updated.'
    else
      render action: 'edit'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_option
    @option = Option.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def option_params
    params.require(:option).permit(:time_zone)
  end
end
