window.VIP ?= {}

class window.VIP.GuestForm

  constructor: (@options) ->
    @setupWebcamControls(@options.webcamControls)

  setupWebcamControls: (options) ->

    ###
    INITIALIZE
    ###

    # disable save button
    @toggleSaveable(false, options)

    # show modal when element is clicked
    $(options.displayWebcam).on 'click',
      @initializeWebcam

    ###
    CONTROLS
    ###

    # disable snap picture button when clicked
    $(options.takePicture).on 'click', =>
      @toggleSaveable(true, options)

    # when refresh is clicked
    $(options.reset).on 'click', =>
      @toggleSaveable(false, options)

    # when save is clicked
    $(options.savePhoto).on 'click', =>
      if @isSaveable(options.savePhoto)
        # create photo
        $.ajax
          type: 'POST'
          url: '/photos/webcam_create'
          dataType: 'json'
          success: (data) =>
            # set id of guest's webcam image
            $('#guest_webcam_photo_id').attr('value', data.id)
            # replace placeholder image
            $.ajax
              type: 'GET'
              url: "/photos/link?id=#{data.id}"
              success: (data) =>
                $('#avatar-placeholder img').attr('src', data.url)

        # dismiss modal
        $('#webcamModal').modal('hide')
      # disable button
      $(options.savePhoto).toggleClass('disabled', true)

    ###
    OTHER
    ###

    # when modal is dismissed
    $('#webcamModal').on 'hidden', =>
      @toggleSaveable(false, options)

  toggleSaveable: (bool, options) ->
    $(options.takePicture).toggleClass('disabled', bool)
    $(options.savePhoto).toggleClass('disabled', !bool)

  isSaveable: (element) =>
    true unless $(element).hasClass('disabled')

  savePhoto: =>
    # create photo on server
    # add to page in thumbnail
    # dissmiss modal

  # must be run in context where this == window.VIP.GuestForm
  initializeWebcam: =>

    options = @options.webcamOptions

    webcam.set_swf_url(options.swf_path)
    webcam.set_api_url(options.api_url)
    webcam.set_quality(options.quality)
    webcam.set_shutter_sound(options.play_sound, options.sound_path)
    webcam.set_stealth(options.set_stealth)

    uploadComplete = (message) ->
      if (message == 'ok')
        $('#save-photo').show()
        $('#photo_description').focus()
      else
        alert('An error occured')
        webcam.reset();

    onloadComplete = =>
      ### fetch the CSRF meta tag data ###
      csrf_param = $('meta[name=csrf-param]').attr('content')
      csrf_token = $('meta[name=csrf-token]').attr('content')
      api_url = options.api_url

      ### reset the api URL appending the auth token parameter ###
      webcam.set_api_url(api_url + '?' + csrf_param + "=" + encodeURI(encodeURI(csrf_token)))

    webcam.set_hook('onLoad', onloadComplete)
    webcam.set_hook('onComplete', uploadComplete)

    $(options.div_id).html(
      webcam.get_html(
        options.width, options.height,
        options.serverWidth, options.serverHeight
      )
    )

  # create photo on server
  createUploadedPhoto: ->

