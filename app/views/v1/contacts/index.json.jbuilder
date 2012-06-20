json.(@query, :count, :limit, :offset)
json.latest @contacts.pluck(:updated_at).max
json.contacts(@contacts){ |json, contact| json.partial! contact }
