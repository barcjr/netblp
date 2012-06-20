$ = jQuery
window.Netblp ||= {}

template = """<form autocomplete="off"></form>"""

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
    @element.append "<span class='note'></span>"
    @ui.note = @element.find ".note"
    @addWidget  "callsign",   Netblp.CallsignWidget
    @addWidget  "category",   Netblp.CategoryWidget
    @addWidget  "section",    Netblp.SectionWidget
    @element.append "<input type='submit' value='Log'>"

    @ui.exchange = $([@ui.callsign, @ui.category, @ui.section].map (widget) -> widget.ui.input[0])
    @ui.exchange.on "keydown", @onTab

    @element.on
      submit: @onSubmit
      keydown: @onEsc

    @ui.callsign.element.on
      callsigncomplete: @onComplete

    @ui.band.ui.input.on "change", @updateBandMode
    @ui.mode.ui.input.on "change", @updateBandMode
    @updateBandMode()

  addWidget: (name, klass, options) =>
    @ui[name] = new klass(options)
    @ui[name].element.appendTo @element

  reset: =>
    @ui.callsign.reset()
    @ui.category.reset()
    @ui.section.reset()

    @ui.callsign.focus()

  updateBandMode: =>
    @ui.callsign.updateBandMode @ui.band.ui.input.val(), @ui.mode.ui.input.val()

  onSubmit: (e) =>
    e.preventDefault()
    $.ajax
      type: "post"
      url: "/v1#{location.pathname}/contacts"
      data: @element.serialize()
      success: @onSuccess
      error: @onError

  onSuccess: (data) =>
    station =
      callsign: data.callsign
      cateogry: data.category
      section: data.section
      dupe: true
    @ui.callsign.add station
    @reset()
    return

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
    return

  onEsc: (e) =>
    if e.which == 27
      @reset()
    return

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
    return
  
  onComplete: (e) =>
    station = @ui.callsign.getStation()
    if station.dupe
      setTimeout @reset, 0
      @ui.note.text "DUPE!"
      setTimeout((=> @ui.note.text ""), 1500)
      return
    @ui.category.ui.input.val(station.category).change()
    @ui.section.ui.input.val(station.section).change()
    return
