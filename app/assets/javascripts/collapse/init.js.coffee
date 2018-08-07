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
        $.scrollTo(link, 500, { offset: -15 })
        return
    return

  # Set hashes and some replaces for it
  clear_anchor = (str, element) ->
    result_string = str.replace("(","").replace(")","").replace('«',"").replace('»', "").replace("-", "_")

    if $(element).hasClass('js-replaced-dots')
      result_string = result_string.replace(/\./g, "_")

    result_string

  $('.js-slider').each (index, element) ->
    anchor = $(this).attr('id')

    unless anchor
      $(this).append("<span class='js-hidden-element hidden'></span>")
      hidden_element = $('.js-hidden-element')

      linko = $(this)
      linko.text(linko.text().compact())
      translit =  linko.liTranslit(
        elAlias: hidden_element
      )

      if hidden_element.text()
        $(this).attr('id', clear_anchor(hidden_element.text(), this))
        anchor = $(this).attr('id')
        hidden_element.remove()

  return
