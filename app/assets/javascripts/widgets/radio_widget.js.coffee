$ = jQuery
window.Netblp ||= {}

template = """
<div>
  <div><span class="label"></span><span class="note"></span></div>
  <label>
    <span class="label">Radio</span>
    <select name="radio" disabled></select>
  </label>
</div>
"""


class Netblp.RadioWidget
  constructor: (options) ->
    @element = $(template)
    @ui =
      label: @element.find "label"
      input: @element.find "select"
      note:  @element.find ".note"
    @ui.form = options.form

    @element.data "Netblp.widget", this

    setInterval @sync, 1000
    @refresh()

  refresh: =>
    $.ajax
      type: "get"
      url: "/v1#{location.pathname}/radios"
      success: @onSuccess
      error: @onError

  onSuccess: (data) =>
    value = @ui.input.val()
    @ui.input.empty()
    $("<option></option>").appendTo @ui.input
    for radio in data.radios
      $("<option></option>").attr("value", radio.name).text(radio.name).appendTo @ui.input
    @ui.input.val(value)
    @ui.input.val window.localStorage["blpRadio"] if window.localStorage["blpRadio"]
  
  onError: =>
    alert "Could not load radios"

  sync: =>
    radio = @ui.input.val()
    if radio == ""
      @ui.note.text ""
      return
    $.ajax
      type: "get"
      url: "/v1#{location.pathname}/radios/#{radio}"
      success: @onSyncSuccess
      error: @onSyncError
 
  onSyncSuccess: (data) =>
    @ui.note.text(if data.stale then "Radio info out of date" else "")
    @ui.form.updateRadio data.frequency, data.band

  onSyncError: =>
    alert "Could not fetch radio information"
