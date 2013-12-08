module MessagesHelper
  def message_status_label(status)
   attributes = {}

   if status == "invalid" || status == "failed"
     attributes["class"] = "label label-danger"
   elsif status == "sent"
     attributes["class"] = "label label-success"
   else
     attributes["class"] = "label label-default"
   end

   content_tag :span, status.upcase, attributes
  end
end
