class Searcher
  attr_accessor :latitude,:longitude
  def initialize(latitude=0,longitude=0)
    @latitude = latitude
    @longitude = longitude
  end

  # YahooAPIのリクエスト
  def get_yahoo_info(keyword)
    uri = "http://shopping.yahooapis.jp/ShoppingWebService/V1/json/itemSearch?appid=#{ENV['YAHOO_APP_ID']}&query=#{keyword}&sort=-review_count&image_size=76"
    api = Api.new(URI.escape(uri))
    json = api.get
  end

  #楽天APIのリクエスト
  def get_rakuten_info(keyword)
    keyword.gsub!(/☆/, ' ')
    keyword.gsub!(/【/, ' ')
    keyword.gsub!(/】/, ' ')
    uri = "https://app.rakuten.co.jp/services/api/Product/Search/20170426?format=json&keyword=#{keyword}&applicationId=#{ENV['RAKUTEN_APPLICATION_ID']}&affiliateId=#{ENV['RAKUTEN_AFFILIATE_ID']}"
    api = Api.new(URI.escape(uri))
    json = api.get
  end

  #ぐるなびAPIのリクエスト
  def get_food_json
    uri = "https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid=#{ENV['FOOD_SEARCH_APIKEY']}&latitude=#{latitude}&longitude=#{longitude}&range=5"
    api = Api.new(uri)
    json = api.get
  end

end
