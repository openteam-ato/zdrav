@init_url_anchors = ->

  $('.js-slider').click (event) ->
    anchor = $(this).attr('id')

    unless $(this).find('.collapse').is(':visible')
      $.scrollTo($(this), 1000, {
        offset: { top: -10 }
        onAfter: ->
          window.location.hash = anchor
        }
      )

  if window.location.hash
    $("#{window.location.hash}").addClass('open')
    $("#{window.location.hash}").next('.collapse').show()
    $.scrollTo($("#{window.location.hash}"), 1000, {
      offset: { top: -10 }
      }
    )
  return
