@init_banners = ->
  if $('.js-banners ul li').length > 4

    carousel = $('.js-banners').jcarousel({
      auto: 20,
      wrap: 'circular',
      scroll: 1
    })

    $('.js-banners-prev').jcarouselControl
      target: "-=1"
      carousel: carousel

    $('.js-banners-next').jcarouselControl
      target: "+=1"
      carousel: carousel

    $('.js-banners-pagination').jcarouselPagination
      perPage: 1
      carousel: carousel
      item: (page, carouselItems) ->
        "<a class='square' href=\"#" + page + "\"></a>"

    $(".js-banners-pagination").on("jcarouselpagination:active", "a", ->
      $(this).addClass "active"
      return

      ).on("jcarouselpagination:inactive", "a", ->
        $(this).removeClass "active"
        return
    ).jcarouselPagination()

