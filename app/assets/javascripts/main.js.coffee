$ ->

  init_actual() if $('.main_page .actual ul li').length
  init_banners() if $('.js-banners').length
  init_archive_collapser() if $('.js-archive').length

  return
