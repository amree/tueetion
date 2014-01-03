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

  # Generate span to display error text
  def form_errors(form, *elems)
    msg = ''
    elems.each do |elem|
      unless msg.strip.blank?
        msg = msg + ", "
      end

      msg = msg + form.errors[elem].join(", ")
    end

    content_tag "span", msg, class: "help-block"
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

  def dash_if_blank(var)
    if var.blank?
      "-"
    else
      var
    end
  end
end
