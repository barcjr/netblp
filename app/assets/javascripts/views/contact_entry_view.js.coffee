$ = jQuery
window.Netblp ||= {}

template = """<form></form>"""

class Netblp.ContactEntryView
  constructor: ->
    @element = $ template
    @ui = {}

    @element.data "Netblp.view", this

    @addWidget  "frequency",  Netblp.FrequencyWidget
    @addWidget  "band",       Netblp.BandWidget
    @addWidget  "mode",       Netblp.ModeWidget
    @element.append "<hr>"
    @addWidget  "callsign",   Netblp.CallsignWidget
    @addWidget  "category",   Netblp.CategoryWidget
    @addWidget  "section",    Netblp.SectionWidget
    @element.append "<input type='submit' value='Log'>"

    @element.on
      submit: @onSubmit

  addWidget: (name, klass) =>
    @ui[name] = new klass
    @ui[name].element.appendTo @element

  reset: =>
    @ui.callsign.reset()
    @ui.category.reset()
    @ui.section.reset()

    @ui.callsign.focus()

  onSubmit: (e) =>
    e.preventDefault()
    $.ajax
      type: "post"
      url: "/v1#{location.pathname}/contacts"
      data: @element.serialize()
      success: @onSuccess
      error: @onError

  onSuccess: (data) =>
    @reset()

  onError: () =>
    alert "Could not save contact!"
