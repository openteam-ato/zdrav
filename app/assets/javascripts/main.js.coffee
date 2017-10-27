$ ->

  init_cetutient()

  init_actual() if $('.main_page .actual ul li').length

  if $('html').is('.ie6, .ie7, .ie8') && $('.main_page .actual ul li').length
    setTimeout ->
      init_actual()
      return
    , 1000

  init_ajaxed() if $('.js-ajaxed').length
  init_banners() if $('.js-banners').length
  init_archive_collapser() if $('.js-archive').length
  init_galleria() if $('.js-galleria').length
  init_iframe_resize() if $('#autoIframe').length
  init_slider() if $('.js-slider').length
  init_collapse() if $('.need-collapse').length
  init_colorbox() if $('a.colorbox').length
  init_location_map() if $('a.js-location-map').length
  init_delete_file() if $('.delete_file').length
  init_doctors_carousel() if $('.js-doctors-carousel').length
  init_autocomplete() if $('.js-autocomplete').length
  init_video_fileupload() if $('.js-file-upload-wrapper').length
  init_anketa_calculator() if $('.js-anketa-samodiagnostiki').length
  init_video_detect()

  $('.datetimepicker').datetimepicker()

  $(document). on 'click', 'a.disabled', ->
    false

  $('input.coupon').inputmask
    mask: '9999 9999'

  return
