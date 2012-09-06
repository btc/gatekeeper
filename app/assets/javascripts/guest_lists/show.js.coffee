window.VIP ?= {}

class window.VIP.GuestListShow
  constructor: (options) ->
    @initTokenInput(options.$tokenInput)

  initTokenInput: ($tokenInput) ->
    $tokenInput.tokenInput(
      '/api/guests/full_name_search'
      preventDuplicates: true
      searchDelay: 0
      animateDropdown: false
      hintText: 'add guests by name'
      noResultsText: 'guest not found'
      caching: true
    )
