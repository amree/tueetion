class InvitationsController < ApplicationController
  before_action :set_invitation, only: [:edit, :update, :destroy, :reinvite]

  # GET /invitations
  def index
    @invitations = current_center.invitations.where(is_used: false)
  end

  # GET /invitations/new
  def new
    @invitation = Invitation.new
  end

  # POST /invitations
  # POST /invitations.json
  def create
    @invitation = current_center.invitations.new(invitation_params)

    respond_to do |format|
      if @invitation.save
        UserMailer.invitation(@invitation).deliver
        format.html { redirect_to staffs_path, notice: 'Invitation was successfully sent.' }
        format.json { render action: 'show', status: :created, location: invitations_path }
      else
        format.html { render action: 'new' }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invitations/1
  # DELETE /invitations/1.json
  def destroy
    @invitation.destroy

    respond_to do |format|
      format.html { redirect_to staffs_path, notice: "Invitation was successfully deleted." }
      format.json { head :no_content }
    end
  end

  def reinvite
    UserMailer.invitation(@invitation).deliver

    redirect_to staffs_path, notice: "Invitation was successfully resent."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invitation
      @invitation = current_center.invitations.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invitation_params
      params.require(:invitation).permit(:center_id, :email, :key, :is_used)
    end
end
