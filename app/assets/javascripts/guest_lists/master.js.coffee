window.VIP ?= {}

class window.VIP.GuestListMaster
  constructor: (options) ->
    options.$input.keyup ->
      val = encodeURI(options.$input.val())
      options.$container.load("#{options.url}?q=#{val} #invitations")


