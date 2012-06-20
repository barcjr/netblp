$ = jQuery
window.Netblp ||= {}

template = """
<div>
  <label>
    <span class="label"></span>
    <input type="text">
  </label>
</div>
"""

class Netblp.OperatorWidget
  constructor: (options)->
    @element = $(template)
    @ui =
      label: @element.find ".label"
      input: @element.find "input"

    @ui.label.text options.label
    @ui.input.attr "name", options.key

    @ui.input.autocomplete
      autoFocus: true
      delay: 50
      source: @query

    @ui.input.on "focus", @refresh
    @ui.input.on "autocompleteselect", @onSelect

    @element.data "Netblp.widget", this


  refresh: =>
    @xhr = $.ajax
      type: "get"
      url: "/v1#{location.pathname}/operators"

  query: (query, callback) =>
    term = query.term.toUpperCase()
    @xhr.done (data) =>
      result = (operator.name for operator in data.operators when operator.name.toUpperCase().indexOf(term) != -1)
      result.push("Add New Operator")
      callback result

  onSelect: (e, ui) =>
    if ui.item.value == "Add New Operator"
      alert "Add new operator"
      return false
