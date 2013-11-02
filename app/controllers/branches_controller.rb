class BranchesController < ApplicationController
  before_action :set_center
  before_action :set_branch, only: [:show, :edit, :update, :destroy]

  # GET /branches/new
  def new
    @branch = Branch.new
  end

  # GET /branches/1/edit
  def edit
  end

  # POST /branches
  # POST /branches.json
  def create
    @branch = @center.branches.build(branch_params)

    respond_to do |format|
      if @branch.save
        format.html { redirect_to @center, notice: 'Branch was successfully created.' }
        format.json { render action: 'show', status: :created, location: @center }
      else
        format.html { render action: 'new' }
        format.json { render json: @branch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /branches/1
  # PATCH/PUT /branches/1.json
  def update
    respond_to do |format|
      if @branch.update(branch_params)
        format.html { redirect_to @center, notice: 'Branch was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @branch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /branches/1
  # DELETE /branches/1.json
  def destroy
    @branch.destroy
    respond_to do |format|
      format.html { redirect_to branches_url }
      format.json { head :no_content }
    end
  end

  private
    def set_center
      @center = Center.find(params[:center_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_branch
      @branch = @center.branches.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def branch_params
      params.require(:branch).permit(:center_id, :name)
    end
end
