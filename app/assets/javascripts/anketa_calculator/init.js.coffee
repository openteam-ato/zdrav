@init_anketa_calculator = ->
  anketa_form = $('.js-anketa-samodiagnostiki')
  results_field = $('.anketa-results')
  results_list = $('.results-list')
  question_count = $('.form-group.radio_buttons').size()
  results_filled_attention = $('.results-filled-attention')
  gender = $('.js-radio-gender')

  # Toggle alcohol labels text
  toggle_alcohol_label_text = (gender) ->
    first_label_text = $('.js-radio-alcohol').closest('label').first().contents()[1]
    second_label_text = $('.js-radio-alcohol').closest('label').last().contents()[1]

    if gender == 'man'
      first_label_text.data  = 'Меньше 500 мл'
      second_label_text.data = 'Больше 500 мл'
    else
      first_label_text.data  = 'Меньше 250 мл'
      second_label_text.data = 'Больше 250 мл'

  # Check gender
  check_gender = () ->
    $('.js-radio-gender').on "change", ->
      if parseInt($(this).val()) == 1
        toggle_alcohol_label_text('man')
      if parseInt($(this).val()) == 0
        toggle_alcohol_label_text('woman')

  # Set active results class
  set_active_results_class = (element) ->
    element.addClass('anketa-active-results')
           .siblings('li')
           .removeClass('anketa-active-results')

  # Check result list
  check_results_list = (summary, radio_buttons_checked) ->
    if radio_buttons_checked.size() == question_count
      if summary < 8
        set_active_results_class($('.results-list-item-8', results_list))

      if summary >= 8 && summary <= 15
        set_active_results_class($('.results-list-item-8-15', results_list))

      if summary > 15
        set_active_results_class($('.results-list-item-15', results_list))

  # Visual styles for results field for this
  check_question_count = (radio_buttons_checked) ->
    if radio_buttons_checked.size() == question_count
      results_filled_attention.hide()
      results_list.fadeIn('slow')

  # Calculate summary points function
  calculate_results = ->
    radio_buttons_checked = $('.form-group.radio_buttons input:checked', anketa_form)
    summary = 0

    radio_buttons_checked.each ->
      summary += parseInt($(this).val())

    check_question_count(radio_buttons_checked)
    check_results_list(summary, radio_buttons_checked)

    return summary

  # Form changes detect
  $(anketa_form).on "change", ->
    results_field.val(calculate_results())

  # Initial gender checking
  check_gender()

  return
