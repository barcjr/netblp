$ = jQuery
window.Netblp ||= {}

template = """
<div>
  <label>
    <span class="label">Category</span>
    <input type="text" name="category">
  </label>
</div>
"""

class Netblp.CategoryWidget
  constructor: ->
    @element = $(template)
    @ui =
      label: @element.find "label"
      input: @element.find "input"

    new Netblp.UpcaseBehavior @ui.input

    @element.data "Netblp.widget", this

