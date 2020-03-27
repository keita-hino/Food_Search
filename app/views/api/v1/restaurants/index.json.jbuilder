json.restaurants @restaurants do |restaurant|
  json.merge! restaurant.attributes
  json.short_open_info restaurant.short_open_info
  json.short_address restaurant.short_address
end

json.users @users