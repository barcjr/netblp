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
