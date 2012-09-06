window.VIP ?= {}

class window.VIP.GuestListForm

  constructor: (@options) ->
    @configureModal(
      @options.$modal
      @options.$guestForm
      @options.$tokenInput
    )
    @configureTokenInput(
      @options.$tokenInput
      @options.savedSelections
    )
    @configureDatepicker(@options.$datepicker)

  configureDatepicker: ($datepicker) ->
    $datepicker
      .datepicker(format: 'yyyy-mm-dd')

  configureModal: ($modal, $form, $tokenInput) ->
    @configureLinksToFocusForm($modal)
    @configureButton($modal)
    # listen for ajaxComplete in modal and capture it
    $modal.ajaxComplete (event, XMLHttpRequest, ajaxOptions) =>
      status = XMLHttpRequest.status
      CREATED = 201
      # if success response is received, hide the modal
      # and add created guest tokenInput form
      if status == CREATED
        guest = JSON.parse XMLHttpRequest.responseText
        @addGuestToTokenInput(guest, $tokenInput)
        # hide the modal
        $modal.modal('hide')
        # reset the form
        $form[0].reset()
        # focus tokenInput

  configureButton: ($modal) ->
    $submitButton = $('.guest-form-submit') # TODO put outside file
    $submitButton.button()

    # set in loading state on submit and prevent events from firing
    $modal.ajaxSend (event, XMLHttpRequest, ajaxOptions) =>
      $submitButton.button('loading')

    # on complete, reset
    # it will hide modal if successful so no need to worry about that
    $modal.ajaxComplete (event, XMLHttpRequest, ajaxOptions) =>
      $submitButton.button('reset')

  configureLinksToFocusForm: ($modal) ->
    $modal.on 'shown', ->
      $("input[type='text']:first", $modal).focus()

  configureTokenInput: ($tokenInput, savedSelections) ->
    $tokenInput.tokenInput(
      '/api/guests/full_name_search'
      preventDuplicates: true
      searchDelay: 0
      animateDropdown: false
      hintText: 'add guests by name'
      noResultsText: 'guest not found'
      caching: false
      prePopulate: savedSelections
    )

  addGuestToTokenInput: (guest, $tokenInput) ->
    $tokenInput.tokenInput 'add',
      id: guest.id
      name: guest.first_name + ' ' + guest.last_name
