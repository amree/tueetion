module MessagesHelper
  def message_status_label(status)
   attributes = {}

   # Reference: https://www.twilio.com/docs/api/rest/message#sms-status-values
   if status == "invalid" || status == "failed" || status == "no credit" || status == "undelivered"
     attributes["class"] = "label label-danger"
   elsif status == "delivered"
     attributes["class"] = "label label-success"
   elsif status == "queued" || status == "sending" || status == "sent"
     attributes["class"] = "label label-warning"
   else
     attributes["class"] = "label label-default"
   end

   content_tag :span, status.upcase, attributes
  end
end
