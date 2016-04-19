@init_video_fileupload = ->
  $('.js-video-file').closest('.content').on 'click','.js-video-file', ->
    $('.js-video-file').fileupload
      type: 'POST'

      add: (e, data) ->
        file = data.files.first()
        wrapper = $(this).closest('.js-file-upload-wrapper')

        $(this).toggleClass('hidden')
        $(this).after("<div><p>#{file.name} <span class='glyphicon glyphicon-remove js-delete-button cursor-pointer' title='Удалить'></span></p>")
        wrapper.find('.js-progress-bar-wrapper').toggleClass('hidden')

        $('.js-submit').click (e) ->
          e.preventDefault()
          data.submit()

        $('.js-delete-button', wrapper).click (e) ->
          wrapper = $(this).closest('.js-file-upload-wrapper')
          wrapper.find('.js-progress-bar-wrapper').toggleClass('hidden')
          wrapper.find('.js-video-file').toggleClass('hidden')
          $(this).parent().remove()
          $('.js-submit').unbind('click')

      progressall: (e, data) ->
        progress = parseInt(data.loaded / data.total * 100, 10)
        $('.js-progress-bar').css 'width', progress + '%'

      always: (e, data) ->
        wrapped = $('<div>', { html: data.result })
        if $('form', wrapped).length
          $('.js-video-message-form').html($('form', wrapped).html())
        else
          window.location = data.result
