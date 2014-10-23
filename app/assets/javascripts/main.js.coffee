$ ->

  init_actual() if $('.main_page .actual ul li').length
  init_ajaxed() if $('.js-ajaxed').length
  init_banners() if $('.js-banners').length
  init_archive_collapser() if $('.js-archive').length
  init_galleria() if $('.js-galleria').length
  init_iframe_resize() if $('#autoIframe').length
  init_slider() if $('.js-slider').length
  init_collapse() if $('.need-collapse').length
  init_colorbox() if $('a.colorbox').length
  init_delete_file() if $('.delete_file').length
  init_doctors_carousel() if $('.js-doctors-carousel').length

  return
