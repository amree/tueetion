class CallbacksController < ApplicationController
  skip_before_filter :authenticate_user!
  skip_before_filter :verify_authenticity_token

  # POST /callbacks/twilio
  def twilio
    message = Message.find_by_sid(params[:SmsSid]) || not_found
    message.sent_content = params[:Body]
    message.status = params[:SmsStatus]

    message.save

    render :text => "OK", :content_type => Mime::TEXT
  end
end
