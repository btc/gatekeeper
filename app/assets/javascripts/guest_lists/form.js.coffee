window.VIP ?= {}

class window.VIP.GuestListSelectForm

  constructor: (@options) ->
    $(@options.id).tokenInput(
      '/api/guests/full_name_search'
      preventDuplicates: true
      searchDelay: 0
      animateDropdown: false
      hintText: 'add guests by name'
      noResultsText: 'guest not found'
      caching: false
      prePopulate: @options.savedSelections
    )
