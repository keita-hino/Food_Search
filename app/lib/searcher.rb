class Searcher
  attr_accessor :latitude,:longitude
  def initialize(latitude=0,longitude=0)
    @latitude = latitude
    @longitude = longitude
  end

  #楽天APIのリクエスト
  def get_rakuten_info(keyword)
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
