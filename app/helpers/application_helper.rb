module ApplicationHelper
  def flash_class(level)
    case level
    when :notice then "alert-info"
    when :success then "alert-success"
    when :error then "alert-danger"
    when :alert then "alert-danger"
    end
  end

  def form_group(conditions, attributes = {}, &block)
    if conditions
      attributes["class"] = "form-group has-error"
    else
      attributes["class"] = "form-group"
    end

    content_tag "div", attributes, &block
  end

  def status_label(status)
    attributes = {}
    content = nil

    if status
      attributes["class"] = "label label-success"
      content = "ACTIVE"
    else
      attributes["class"] = "label label-default"
      content = "INACTIVE"
    end

    # content_tag "span", attributes, content
    content_tag :span, content, attributes
  end
end
