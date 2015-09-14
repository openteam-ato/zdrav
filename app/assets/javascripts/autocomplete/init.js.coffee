@init_autocomplete = ->
  input = $('.js-autocomplete')

  return if !input.length

  input.autocomplete
    source: input.data('url')
    minLength: 2
    select: (event, ui) ->
      input.val(ui.item.value)
      return

  return
