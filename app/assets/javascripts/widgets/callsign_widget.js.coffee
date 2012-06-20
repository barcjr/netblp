$ = jQuery
window.Netblp ||= {}

template = """
<div>
  <label>
    <span class="label">Callsign</span>
    <input type="text" name="callsign">
  </label>
</div>
"""

class Netblp.CallsignWidget
  constructor: ->
    @element = $(template)
    @ui =
      label: @element.find "label"
      input: @element.find "input"

    new Netblp.UpcaseBehavior @ui.input

    @element.data "Netblp.widget", this

    @ui.input.autocomplete
      source: @query
      select: @onSelect
      position:
        my: "left top"
        at: "right top"

    @ui.input.on
      blur: @onBlur
      focus: => @ui.input.autocomplete("search")
  
  reset: =>
    @ui.input.val ""

  focus: =>
    @ui.input.focus()

  query: (query, callback) =>
    term = query.term.toUpperCase()
    unless term.length > 0
      callback []
      return
    $.ajax
      type: "get"
      url: "/v1#{location.pathname}/stations"
      data: {partial: term, band: @band, mode: @mode, limit: 10}
      success: (data) =>
        @stations = {}
        @stations[station.callsign] = station for station in data.stations
        callback(@formatCompletion(station) for callsign, station of data.stations)
        return
      error: =>
        alert "Could not load stations for dupe check!"
        return

  formatCompletion: (station) ->
    {value: station.callsign, label: "#{station.callsign} #{station.category} #{station.section}#{if station.dupe then " - DUPE!" else ""}"}

  updateBandMode: (@band, @mode) =>
