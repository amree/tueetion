require 'message_processor'

class SmsSenderWorker
  @queue = :sms

  def self.perform(id)
    message = Message.find(id)

    if message.present?
      sender = MessageSender.new(message)
      sender.send
    end
  end
end
