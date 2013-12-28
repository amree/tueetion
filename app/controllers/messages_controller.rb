class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    @messages = current_center.messages.order("created_at DESC")
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    if current_center.credits.try(:available).blank?
      redirect_to messages_path, notice: "You don't have any message credit in your account. Please contact support for further information."
    else
      @message = Message.new
    end
  end

  # POST /messages
  # POST /messages.json
  def create
    # Build arrays of data
    arr = Array.new
    params[:student_ids].split(",").each do |id|
      h = params[:message].merge("student_id" => id, "center_id" => current_center.id)
      h.permit!

      arr << h
    end

    # new_params = ActionController::Parameters.new(data: arr)
    # new_params.permit(data: [:content, :student_id, :center_id])
    # new_params.permit!

    if Message.create(arr)
      redirect_to new_message_path, notice: 'Message was successfully queued. Please see messages list to get the latest status.'
    else
      render action: 'new'
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  # GET /messages/1/update_status
  def update_status
    @message = current_center.messages.find(params[:message_id])

    client = Twilio::REST::Client.new TWILIO_CONFIG['sid'], TWILIO_CONFIG['token']
    res = client.account.messages.get @message.sid

    if res.status.present? && @message.update_attributes(status: res.status)
      redirect_to @message, notice: "Message's status was successfully updated."
    else
      redirect_to @message, alert: "Message's status cannot be updated."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = current_center.messages.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      # params.require(:student_ids)
      # params.require(:message).permit([:student_id, :center_id, :content])
      # params.permit([:content], [:content])
      # params.permit!
    end
end
