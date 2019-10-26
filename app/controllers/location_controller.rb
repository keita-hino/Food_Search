class LocationController < WebsocketRails::BaseController 
  def show 
    puts message WebsocketRails[:location_channel].trigger "location", message 
  end
end