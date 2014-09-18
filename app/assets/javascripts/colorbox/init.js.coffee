@init_colorbox = ->

  $('a.colorbox').attr('rel', 'colorbox').colorbox
    close: 'закрыть'
    current: '{current} из {total}'
    maxHeight: '90%'
    maxWidth: '90%'
    next: 'следующая'
    opacity: '0.2'
    photo: true
    previous: 'предыдущая'
    returnFocus: false
    title: ->
      $(this).attr('title') || $('img', this).attr('alt')

  return
