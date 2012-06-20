json.count @radios.count
json.radios(@radios){ |json, radio| json.partial! radio }
