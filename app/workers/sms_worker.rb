class SmsWorker
  @queue = :sms

  def self.perform(id)
    message = Message.find(id)

    if message.present?
      to = message.phone_number
      body = message.content

      client = Twilio::REST::Client.new TWILIO_CONFIG['sid'], TWILIO_CONFIG['token']
      rs =  client.account.messages.create from: TWILIO_CONFIG['from'], to: to, body: body, status_callback: "http://#{TWILIO_CONFIG['callback_host']}/callbacks/twilio"

      message.sid = rs.sid
      message.save
    end
  end
end
