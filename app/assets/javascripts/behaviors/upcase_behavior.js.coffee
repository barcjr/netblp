$ = jQuery
window.Netblp ||= {}

class Netblp.UpcaseBehavior
  constructor: (element) ->
    @element = $ element
    @element.addClass "upcase"
    @element.on "change", @upcase
    @element.data "Netblp.UpcaseBehavior", this

  upcase: =>
    @element.val @element.val().toUpperCase()
