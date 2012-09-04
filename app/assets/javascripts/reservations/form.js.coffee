window.VIP ?= {}

class window.VIP.ReservationForm
  constructor: (options) ->
    @configureTokenInput(options.$guestInputField, options.$data)

  configureTokenInput: ($field, $data) ->
    $field.tokenInput(
      '/api/guests/full_name_search'
      preventDuplicates: true
      tokenLimit: 1
      searchDelay: 0
      animateDropdown: false
      hintText: 'lookup guest by name'
      noResultsText: 'guest not found'
      caching: false
      prePopulate: $data
    )

