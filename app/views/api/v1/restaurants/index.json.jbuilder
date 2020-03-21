json.restaurants @restaurants do |restaurant|
  json.merge! restaurant.attributes
  json.is_fetch true
end
