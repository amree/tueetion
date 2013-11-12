module BillsHelper
  def bill_status_label(status, true_val, false_val)
    attributes = {}
    content = nil

    if status
      attributes["class"] = "label label-success"
      content = true_val
    else
      attributes["class"] = "label label-danger"
      content = false_val
    end

    # content_tag "span", attributes, content
    content_tag :span, content, attributes
  end
end
