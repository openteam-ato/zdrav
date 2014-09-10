@init_archive_collapser = ->
  year = $('.year', '.js-archive')

  year.each ->
    $(this).next('ul').show() if $(this).hasClass('active')

  year.click ->
    $this = $(this)

    $this.toggleClass('active').next('ul').stop(true, true).slideToggle 'slow', ->
      $this.removeClass('busy')

    false
