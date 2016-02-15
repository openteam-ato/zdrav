@init_location_map = ->

  location_map = $('<div />').html('location map')
  html = '<iframe frameborder="no" width="100%" height="100%" src="http://widgets.2gis.com/widget?type=firmsonmap&amp;options=%7B%22pos%22%3A%7B%22lat%22%3A56.46639650365686%2C%22lon%22%3A84.97241377830505%2C%22zoom%22%3A16%7D%2C%22opt%22%3A%7B%22city%22%3A%22tomsk%22%7D%2C%22org%22%3A%22422740746441733%22%7D"></iframe>'

  $('a.js-location-map').click ->
    link = $(this)
    $.colorbox
      innerWidth: '80%'
      innerHeight: '80%'
      title: link.data('title')
      html: location_map
      scrolling: false
      opacity: '0.2'
      onComplete: ->
        location_map.html(html)
        return

    return false

  return
