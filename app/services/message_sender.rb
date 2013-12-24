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

      # Search for free credit
      credit = Credit.available(@message.center_id).first

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

        client = Twilio::REST::Client.new(TWILIO_CONFIG['sid'], TWILIO_CONFIG['token'])

        rs =  client.account.messages.create(
                from: TWILIO_CONFIG['from'],
                to: to,
                body: body,
                status_callback: "http://#{TWILIO_CONFIG['callback_host']}/callbacks/twilio")

        @message.sid = rs.sid
        @message.status = 'in progress'

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
