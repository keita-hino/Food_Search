json.restaurants @restaurants do |restaurant|
  json.merge! restaurant.attributes
end
