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

    setInterval @refreshStations, 10000

    @ui.input.autocomplete
      source: @query
      select: @onSelect

    @ui.input.on
      blur: @onBlur
  
  reset: =>
    @ui.input.val ""

  focus: =>
    @ui.input.focus()

  query: (query, callback) =>
    term = query.term.toUpperCase()
    callback({value: callsign, label: "#{callsign} #{station.category} #{station.section}#{if station.dupe then " - DUPE!" else ""}"} for callsign, station of @stations when callsign[0...term.length].toUpperCase() == term)

  updateBandMode: (@band, @mode) =>
    @refreshStations()

  refreshStations: =>
    @xhr = $.ajax
      type: "get"
      url: "/v1#{location.pathname}/stations"
      data: {limit: -1, band: @band, mode: @mode}
      success: @onSuccess
      error: @onError

  onSuccess: (data) =>
    @stations = {}
    for station in data.stations
      @stations[station.callsign] = station
    return

  onError: () =>
    alert "Stations failed to load!"
    return

  add: (station) =>
    return if @stations[station.callsign] != undefined
    @stations[station.callsign] = station

  onSelect: (e, ui) =>
    @ui.input.val ui.item.value
    @onBlur(e)

  onBlur: (e) =>
    @element.trigger "callsigncomplete", e if @stations[@ui.input.val()]
    return

  getStation: =>
    @stations[@ui.input.val()]
