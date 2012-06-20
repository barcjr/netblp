$ = jQuery
window.Netblp ||= {}

template = """
<div title="Add New Operator">
  <form autocomplete="off">
    <div><label>First Name<input type="text" name="first_name"></label></div>
    <div><label>Last Initial<input type="text" name="last_initial" maxlength=1></label></div>
    <div><label>Callsign (optional)<input type="text" name="callsign"></label></div>
    <input type="submit" value="Add Operator">
  </form>
</div>
"""

class Netblp.AddOperatorView
  constructor: ->
    @element = $ template
    @ui = {}
    @ui.form = @element.find "form"

    @ui.first_name    = @ui.form.find "[name=first_name]"
    @ui.last_initial  = @ui.form.find "[name=last_initial]"
    @ui.callsign      = @ui.form.find "[name=callsign]"

    new Netblp.UpcaseBehavior @ui.callsign

    @ui.form.on "submit", @onSubmit

    @element.data "Netblp.view", this

    @element.appendTo "body"

    @element.dialog
      autoOpen: false
      modal: true
      width: 512
      close: @reset

  onSubmit: (e) =>
    e.preventDefault()
    if @ui.first_name.val() == ""
      alert "First Name is required!"
      return
    if @ui.last_initial.val() == ""
      alert "Last Initial is required!"
      return
    
    name = "#{@ui.first_name.val()} #{@ui.last_initial.val()}."
    if @ui.callsign.val() != ""
      name += " (#{@ui.callsign.val()})"

    $.ajax
      type: "post"
      url: "/v1#{location.pathname}/operators"
      data: {name: name}
      success: @onSuccess
      error: @onError

  open: (@callback) =>
    @element.dialog "open"

  close: =>
    @callback = null
    @reset()
    @element.dialog "close"

  reset: =>
    @ui.form.find("input[type=text]").val ""
    true

  onSuccess: (data) =>
    if @callback
      @callback data.name
    @close()
    true

  onError: =>
    alert "Failed to add operator!"
    true

$ ->
  Netblp.AddOperatorView = new Netblp.AddOperatorView
