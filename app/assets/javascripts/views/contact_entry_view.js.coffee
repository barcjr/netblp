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

  addWidget: (name, klass) =>
    @ui[name] = new klass
    @ui[name].element.appendTo @element
