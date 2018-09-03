@init_cute_counter = ->
  counter = $('.js-cute-counter')
  count_number = $('.js-cute-counter-data').data('count')

  counter.html(count_number)
  return
