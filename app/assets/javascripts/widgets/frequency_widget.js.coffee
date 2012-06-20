$ = jQuery
window.Netblp ||= {}

template = """
<div>
  <label>
    <span class="label">Frequency</span>
    <input type="text">
    <input type="hidden" name="frequency">
  </label>
</div>
"""


class Netblp.FrequencyWidget
  constructor: ->
    @element = $(template)
    @ui =
      label: @element.find "label"
      input: @element.find "input[type='text']"
      value: @element.find "input[type='hidden']"

    @ui.input.on "change", @onChange

    @element.data "Netblp.widget", this

  formatFrequency: (frequency) ->
    return frequency if frequency instanceof String
    return "" if isNaN frequency

    if frequency >= 1e9
      suffix = "GHz"
      number = frequency / 1e9
    else if frequency >= 1e6
      suffix = "MHz"
      number = frequency / 1e6
    else if frequency >= 1e3
      suffix = "KHz"
      number = frequency / 1e3
    else
      suffix = "Hz"
      number = frequency

    string = number.toFixed(6)
    "#{string[0...-3]},#{string[-3..-1]} #{suffix}"

    
  parseFrequency: (string) ->
    number = parseFloat(string.replace /[^.\d]/, "")
    switch string[-3..-1]
      when "GHz" then number *= 1e9
      when "MHz" then number *= 1e6
      when "KHz" then number *= 1e3
      else number *= 1e6 # Default to MHz
    return number

  setFrequency: (frequency) =>
    @ui.input.val @formatFrequency(frequency)
    @ui.input.change()

  getFrequency: =>
    @parseFrequency @ui.input.val()

  onChange: (e) =>
    freq = @getFrequency()
    @ui.input.val @formatFrequency(freq)
    @ui.value.val(if isNaN(freq) then "" else freq)
