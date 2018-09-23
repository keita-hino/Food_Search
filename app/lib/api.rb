require 'net/http'
require 'uri'
require 'json'

class Api
  attr_accessor :url
  def initialize(url)
    @url = url
  end
  def get
    uri = URI.parse(url)
    begin
      json = Net::HTTP.get(uri)
      JSON.parse(json)
    rescue
      puts "オフラインです"
      exit
    end
  end

  def post(authorization,message)
    uri = URI.parse("https://notify-api.line.me/api/notify")
    request = Net::HTTP::Post.new(uri)
    request["Authorization"] = authorization
    request.set_form_data(
      "message" => message,
    )

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
  end

  def food_search(lat,lon)
    # latitude = 38.444207
    # longitude = 141.288718

    search = Searcher.new(lat.to_i,lon.to_i)
    json = search.get_info
    pro = Processer.new(json)
    return pro.extraction
  end
  
end
