class CentersController < ApplicationController
  before_action :set_center, only: [:show, :edit, :update, :destroy]

  # GET /centers
  def index
    @centers = Center.all
  end

  # GET /centers/1
  def show
  end

  # GET /centers/new
  def new
    if current_user.center.try(:owner_count) > 0
      redirect_to centers_path, alert: 'Owner can only have one center.'
    else
      @center = Center.new
    end
  end

  # GET /centers/1/edit
  def edit
  end

  # POST /centers
  def create
    @center = Center.new(center_params)
    @center.user_id = current_user.id

    if @center.save
      redirect_to @center, notice: 'Center was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /centers/1
  def update
      if @center.update(center_params)
        redirect_to @center, notice: 'Center was successfully updated.'
      else
        render action: 'edit'
      end
  end

  # DELETE /centers/1
  def destroy
    @center.destroy

    redirect_to centers_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_center
      @center = Center.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def center_params
      params.require(:center).permit(:name)
    end
end
