class CentersController < ApplicationController
  before_action :set_center

  layout "single", only: [:new, :create]

  # GET /centers/1
  def show
  end

  # GET /centers/new
  def new
    if current_center.present?
      redirect_to centers_path, alert: 'You can have only one center.'
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

    if @center.save
      current_user.center_id = @center.id
      current_user.save

      option = @center.build_option
      option.time_zone = 'Kuala Lumpur'
      option.save

      msg = "Center was successfully created.
             We recommend you to take a quick look our Getting Started.
             Just click Help & Support to view it."

      redirect_to @center, notice: msg
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

  # GET /center/bulk_actions
  def bulks
  end

  # GET /center/create_bills
  def create_bills
    current_center.students.active.each do |student|
      Resque.enqueue(BillCreatorWorker, student.id)
    end

    redirect_to bulks_centers_path,
                notice: "Creating bills job has been queued.
                         The bills will be automatically shown when they're ready"
  end

  # GET /center/deactivate_bills
  def deactivate_bills
    time = Time.zone.now.beginning_of_month

    current_center.bills.by_month(time).each do |bill|
      Resque.enqueue(BillDeactivatorWorker, bill.id)
    end

    redirect_to bulks_centers_path,
                notice: "Deactivating bills job has been queued.
                         The bills will be automatically marked as deactivated
                         when they're finished."
  end

  # GET /center/overdue_bills
  def overdue_bills
    current_center.bills.not_overdue.each do |bill|
      Resque.enqueue(BillOverduerWorker, bill.id)
    end

    redirect_to bulks_centers_path,
                notice: "This job has been queued.
                         Every active, non paid bills will be marked as overdued
                         when they're done."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_center
      @center = current_user.center
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def center_params
      params.require(:center).permit(:name)
    end
end

