require 'message_processor'

class MessageSender
  def initialize(message)
    @message = message
  end

  def send
    if @message.status != 'sent'
      # Parse @message first
      processed_message = MessageProcessor.new(@message)
      @message.processed_content = processed_message.content
      @message.price = processed_message.price

      # Search for free credit
      credit = Center.find(@message.center_id).credits.try(:available).first

      credit_balance = if credit
                         credit.amount - credit.used
                       else
                         -1
                       end

      # Only send if there are enough credits available
      if credit && credit_balance >= processed_message.sms_count

        # Build message usages
        Array.new(processed_message.sms_count).each do
          @message.credit_usages.build(credit_id: credit.id)
        end

        # Prepare for @message sending
        to = @message.phone_number
        body = @message.processed_content

        client = Twilio::REST::Client.new(Rails.application.secrets.twilio_sid,
                                          Rails.application.secrets.twilio_token)

        begin
          rs =  client.account.messages.create(
                  from: Rails.application.secrets.twilio_from,
                  to: to,
                  body: body,
                  status_callback: "http://#{Rails.application.secrets.twilio_callback_host}/callbacks/twilio")

          @message.sid = rs.sid
          @message.status = rs.status

        rescue Twilio::REST::RequestError => e
          @message.status = 'invalid'
        end

        ActiveRecord::Base.transaction do
          credit.save
          @message.save
        end
      else
        @message.status = "no credit"
        @message.save
      end
    end
  end
end
