$(document).ready ->
  $('.select-checkbox-onclick').on('click', (e) ->
    checkBox = $(this).children('input:checkbox')
    checkBox.prop('checked', !checkBox.prop('checked'))
  )
  $('.select-checkbox-onclick').children().on('click', (e) ->
    e.stopPropagation();
  )
