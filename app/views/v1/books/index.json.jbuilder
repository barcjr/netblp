json.(@query, :count, :limit, :offset)
json.books(@books){ |json, book| json.partial! book }
