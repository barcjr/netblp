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

    @refreshStations()

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
    callback({value: callsign, label: "#{callsign} #{station.category} #{station.section}"} for callsign, station of @stations when callsign[0...term.length].toUpperCase() == term)

  refreshStations: =>
    @xhr = $.ajax
      type: "get"
      url: "/v1#{location.pathname}/stations"
      data: {limit: -1}
      success: @onSuccess
      error: @onError

  onSuccess: (data) =>
    setTimeout @refreshStations, 10000
    @stations = {}
    for station in data.stations
      @stations[station.callsign] = station
    return

  onError: () =>
    setTimeout @refreshStations, 10000
    alert "Stations failed to load!"
    return

  add: (station) =>
    return if @stations[station.callsign] != undefined
    @stations[station.callsign] = station

  onSelect: (e, ui) =>
    @ui.input.val ui.item.value
    @onBlur(e)

  onBlur: =>
    @element.trigger "callsigncomplete" if @stations[@ui.input.val()]
    return

  getStation: =>
    @stations[@ui.input.val()]
