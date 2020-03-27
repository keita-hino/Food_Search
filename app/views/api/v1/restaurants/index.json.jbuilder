json.restaurants @restaurants do |restaurant|
  json.merge! restaurant.attributes
  json.short_open_info restaurant.short_open_info
  json.short_address restaurant.short_address
end

# TODO:ドットでアクセスできるように修正
json.users @users do |user|
  json.id user[:id]
  json.name user[:name]
  json.url user[:url]
end