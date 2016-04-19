@init_video_detect = ->

  hasFlash = false
  try
    hasFlash = Boolean(new ActiveXObject('ShockwaveFlash.ShockwaveFlash'))
  catch exception
    hasFlash = 'undefined' != typeof navigator.mimeTypes['application/x-shockwave-flash']
  if hasFlash
    $('.flash-player').show()
    $('.html5-player').hide()
    $('.no-player').hide()
  else
    if Modernizr.video
      $('.flash-player').hide()
      $('.html5-player').show()
      $('.no-player').hide()
    else
      $('.flash-player').hide()
      $('.html5-player').hide()
      $('.no-player').show()

  return
