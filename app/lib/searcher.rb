# require './api'

class Searcher
  attr_accessor :latitude,:longitude
  def initialize(latitude,longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def get_info
    uri = "https://api.gnavi.co.jp/RestSearchAPI/20150630/?keyid=#{ENV['FOOD_SEARCH_APIKEY']}&format=json&latitude=#{latitude}&longitude=#{longitude}"
    # api = Api.new(uri)
    # json = api.get
  end

  def out
    a = "out"
  end

end
