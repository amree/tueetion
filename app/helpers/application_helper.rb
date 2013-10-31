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
end
