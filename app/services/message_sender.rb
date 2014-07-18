require 'message_processor'

class MessageSender
  def initialize(message)
    @message = message
    @center  = @message.center
  end

  def send
    ActiveRecord::Base.transaction do
      unless @message.status == 'sent'
        # Parse @message first
        processed_message = MessageProcessor.new(@message)
        @message.processed_content = processed_message.content
        @message.price = processed_message.price

        if @center.credit_balance >= @message.price

          # Deduct from credit balance first
          @center.credit_balance = @center.credit_balance - @message.price

          # Prepare for @message sending
          to   = @message.full_phone_number
          body = @message.processed_content

          client = Twilio::REST::Client.new(Rails.application.secrets.twilio_sid,
                                            Rails.application.secrets.twilio_token)

          begin
            rs = client.account.messages.create(
                   from: Rails.application.secrets.twilio_from,
                   to: to,
                   body: body,
                   status_callback: "http://#{Rails.application.secrets.twilio_callback_host}/callbacks/twilio")

            @message.sid    = rs.sid
            @message.status = rs.status

          rescue Twilio::REST::RequestError => e
            @message.status = 'invalid'
          end

          # Update credit balance and message information
          @center.save
          @message.save
        else
          @message.status = 'no credit'
          @message.save
        end
      end
    end
  end
end
