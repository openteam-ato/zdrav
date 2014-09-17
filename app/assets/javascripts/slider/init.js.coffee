@init_slider = ->
  $('.js-slider').on 'click', ->
    $this = $(this)

    $this.toggleClass('open')
    $this.siblings('.collapse').slideToggle 'fast', ->
      $(this).toggleClass('in')

    false

