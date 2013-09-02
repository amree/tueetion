ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  unless html_tag =~ /^<label/
    errors = Array(instance.error_message).join(',')
    %(<div class="error">#{html_tag}<small class="error">&nbsp;#{errors}</small></div>).html_safe
  else
    %(<div class="error">#{html_tag}</div>).html_safe
  end
end
