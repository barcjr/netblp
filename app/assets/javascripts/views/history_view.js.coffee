$ = jQuery
window.Netblp ||= {}

template = """
<div>
  <em class="note"></em>
  <table>
    <thead>
      <tr>
        <th>Callsign</th>
        <th>Category</th>
        <th>Section</th>
        <th>Band</th>
        <th>Mode</th>
        <th>Operator</th>
        <th>Logger</th>
    </thead>
    <tbody>

    </tbody>
  </table>
</div>
"""

class Netblp.HistoryView
  constructor: ->
    @element = $ template
    @ui = {}
    @ui.body = @element.find("tbody").first()
    @ui.note = @element.find(".note").first()
    @contacts = {}

    @element.data "Netblp.view", this

    @refresh()

  refresh: =>
    $.ajax
      type: "get"
      url: "/v1#{location.pathname}/contacts"
      data: {limit: 25}
      success: @onSuccess
      error: @onError

  onSuccess: (data) =>
    @ui.body.empty()
    for contact in data.contacts
      @ui.body.append(@buildRow contact)
    @ui.note.text "Total Contacts: #{data.count}"

  onError: =>
    alert "Failed to update history"

  buildRow: (contact) =>
    row = $ "<tr></tr>"
    $("<td></td>").text(contact.callsign).appendTo row
    $("<td></td>").text(contact.category).appendTo row
    $("<td></td>").text(contact.section).appendTo row
    $("<td></td>").text(contact.band).appendTo row
    $("<td></td>").text(contact.mode).appendTo row
    $("<td></td>").text(contact.primary_operator).appendTo row
    $("<td></td>").text(contact.secondary_operator).appendTo row
    row
