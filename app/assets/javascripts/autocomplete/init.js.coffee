@init_autocomplete = ->
  $('.js-autocomplete').on 'focus', ->
    $(this).autocomplete
      source: $(this).data('url')
      minLength: 2
      select: (event, ui) ->
        $(this).val(ui.item.value)
        return
    return
