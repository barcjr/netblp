json.(@query, :count, :limit, :offset)
json.contacts(@contacts){ |json, contact| json.partial! contact }
