@init_collapse = ->

  wrapper = $('.need-collapse')

  $('h2', wrapper).click ->
    link = $(this)
    if link.hasClass('open')
      link.next('.collapsible').slideToggle 'fast', ->
        link.toggleClass('open')
        return
    else
      $('.collapsible:visible').slideUp('fast')
      $('h2', wrapper).removeClass('open')
      link.next('.collapsible').slideToggle 'fast', ->
        link.toggleClass('open')
        # $.scrollTo(link, 500, { offset: -15 }) # uncomment if needed auto scroll
        return
    return

  return
