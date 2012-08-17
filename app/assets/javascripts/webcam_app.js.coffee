window.VIP ?= {}

class window.VIP.WebcamApp

  constructor: (options)->
    @initializeWebcam(options)

  initializeWebcam: (options) ->
    webcam.set_swf_url(options.swf_path)
    webcam.set_api_url(options.api_url)
    webcam.set_quality(options.quality)
    webcam.set_shutter_sound(true, options.sound_path)

    uploadComplete = (message) ->
      if (message == 'ok')
        $('#new_photo').show()
        $('#photo_description').focus()
      else
        alert('An error occured')
        webcam.reset();

    onloadComplete = ->
      ### fetch the CSRF meta tag data ###
      csrf_param = $('meta[name=csrf-param]').attr('content')
      csrf_token = $('meta[name=csrf-token]').attr('content')
      api_url = options.api_url

      ### reset the api URL appending the auth token parameter ###
      webcam.set_api_url(api_url + '?' + csrf_param + "=" + encodeURI(encodeURI(csrf_token)))

    webcam.set_hook('onLoad', onloadComplete)
    webcam.set_hook('onComplete', uploadComplete)

    $(options.div_id).html(webcam.get_html(options.width, options.height))
