@init_doctors_carousel = ->

  carousel = $('.js-doctors-carousel').jcarousel
    wrap: 'circular',
    scroll: 1

  carousel.jcarouselAutoscroll
    interval: 10000

  $('.js-doctors-carousel-prev').jcarouselControl
    target: "-=1"
    carousel: carousel

  $('.js-doctors-carousel-next').jcarouselControl
    target: "+=1"
    carousel: carousel

  return
