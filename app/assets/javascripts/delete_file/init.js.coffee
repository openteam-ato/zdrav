@init_delete_file = ->

  $(document).on 'click', 'a.delete_file', ->
    p = $(this).closest('p')
    p.prev('p').html('<input type="hidden" name="doctor[delete_photo]" value="true" />')
    p.text('Изображение удалено. Для подтверждения сохраните изменения')

    false

  return
