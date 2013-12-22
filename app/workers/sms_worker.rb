require 'message_processor'

class SmsWorker
  @queue = :sms

  def self.perform(id)
    message = Message.find(id)

    if message.present?
      # Parse message first
      mp = MessageProcessor.new(message)
      message.processed_content = mp.content

      # Prepare for sending message
      to = message.phone_number
      body = message.processed_content

      client = Twilio::REST::Client.new TWILIO_CONFIG['sid'], TWILIO_CONFIG['token']
      rs =  client.account.messages.create(
              from: TWILIO_CONFIG['from'],
              to: to,
              body: body,
              status_callback: "http://#{TWILIO_CONFIG['callback_host']}/callbacks/twilio")

      message.sid = rs.sid
      message.save
    end
  end
end
