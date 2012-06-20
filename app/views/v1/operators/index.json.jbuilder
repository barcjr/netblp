json.count @operators.length
json.operators(@operators){ |json, operator| json.partial! operator }
