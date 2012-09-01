window.VIP ?= {}

class window.VIP.GuestListIndex

  constructor: (@options) ->
    @setup(behavior, @options.$container) for behavior in @options.tuples
    # load up the initial contents
    @options.$default.click()

  # load results to destination when trigger is clicked
  setup: (request, $container) ->
    request.$trigger.click ->
      # TODO loading spinner
      $container.load(request.url)
