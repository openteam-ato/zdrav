@init_ajaxed = ->
  $('.js-ajaxed').on 'ajax:success', (evt, response, status, jqXHR) ->
    target = $(evt.target)

    target.closest('li').replaceWith(response)

  return
