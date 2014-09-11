@init_galleria = ->
  $('#galleria').galleria({
    width: 846,
    imageCrop: 'height',
    thumbCrop: true,
    transitionSpeed: 500,
    preload: 3,
    easing: "galleriaIn",
    showCounter: false,
    transition: "fade",
    transitionInitial: "fade",
    showInfo: true,
    showFullscreen: true
  })
