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
    @addWidget  "operator",   Netblp.OperatorWidget, {label: "Operator", key: "primary_operator"}
    @addWidget  "logger",     Netblp.OperatorWidget, {label: "Logger", key: "secondary_operator"}
    @element.append "<hr>"
    @addWidget  "callsign",   Netblp.CallsignWidget
    @addWidget  "category",   Netblp.CategoryWidget
    @addWidget  "section",    Netblp.SectionWidget
    @element.append "<input type='submit' value='Log'>"

    @ui.exchange = $([@ui.callsign, @ui.category, @ui.section].map (widget) -> widget.ui.input[0])
    @ui.exchange.on "keydown", @onTab

    @element.on
      submit: @onSubmit

  addWidget: (name, klass, options) =>
    @ui[name] = new klass(options)
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

  onError: (xhr) =>
    try
      errors = JSON.parse(xhr.responseText).errors
      message = "Could not save contact:\n"
      for key, msgs of errors
        for msg in msgs
          message += "#{key} #{msg}\n"
      alert message
    catch e
      alert "Could not save contact (Unknown Reason)!"

  onTab: (e) =>
    if e.which == 9
      e.preventDefault()
      index = @ui.exchange.index e.delegateTarget
      if e.shiftKey
        index--
      else
        index++
      index = 0 if index >= @ui.exchange.length
      index = @ui.exchange.length - 1 if index < 0

      @ui.exchange[index].focus()
