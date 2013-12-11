(($, undefined_) ->
  $.fn.getCursorPosition = ->
    el = $(this).get(0)
    pos = 0
    if "selectionStart" of el
      pos = el.selectionStart
    else if "selection" of document
      el.focus()
      Sel = document.selection.createRange()
      SelLength = document.selection.createRange().text.length
      Sel.moveStart "character", -el.value.length
      pos = Sel.text.length - SelLength
    pos
) jQuery

putTemplateMessage = (elem, template, templates) ->
  target      = $('#message_content')
  preview     = $('#message_content_preview')
  position    = $(target).getCursorPosition()
  content     = $(target).val()

  newContent  = content.substr(0, position)
  newContent += '{{' + template[0] + '}}'
  newContent += content.substr(position)

  $(target).val(newContent)
  replaceTemplateMessage($('#message_content'), $('#message_content_preview'), templates)

# Replace {{var}} with a value
#
replaceTemplateMessage = (content, preview, values) ->
  currentText = $(content).val().trim()

  $.each values, (index, value) ->
    oldValue = '\{\{' + value[0] + '\}\}'

    rx = new RegExp(oldValue, 'g')
    currentText = currentText.replace(rx, value[1])

  $(preview).val(currentText)

ready =->
  container = $('#new_message')

  templates = [['first_name', 'John'], ['last_name', 'Doe'], ['unpaid_amount', '200'], ['unpaid_bill_count', 5]]

  # Message preview
  $('#message_content', container).bind 'propertychange keyup input paste', ->
    replaceTemplateMessage($('#message_content'), $('#message_content_preview'), templates)

    value = $(this).val().trim()
    length = value.length
    $('#content_character_count').text(length)

  # Add data templlate
  $.each templates, (index, value) ->
    $("a[href='#insert_" + value[0] + "']", container).click ->
      putTemplateMessage($(this), value, templates)
      return false

$(document).ready(ready)
$(document).on('page:load', ready)
