class Searcher

  def yahoo_search(keyword,code='999')
    re_keyword = keyword_sanitizing(keyword)
    uri = "http://shopping.yahooapis.jp/ShoppingWebService/V1/json/itemSearch?appid=#{ENV['YAHOO_APP_ID']}&query=#{re_keyword}&sort=-score&image_size=76&availability=1"
    uri << "&category_id=#{code}" unless code == '999'
    json = get_search(uri)
    pro = Processor.new(json)
    hash = pro.yahoo_extraction
    return hash
  end

  def rakuten_search(keyword,code='999')
    re_keyword = keyword_sanitizing(keyword)
    uri = "https://app.rakuten.co.jp/services/api/Product/Search/20170426?format=json&keyword=#{re_keyword}&applicationId=#{ENV['RAKUTEN_APPLICATION_ID']}&affiliateId=#{ENV['RAKUTEN_AFFILIATE_ID']}"
    uri << "&genreId=#{code}" unless code == '999'
    json = get_search(uri)
    pro = Processor.new(json)
    hash = pro.rakuten_extraction
    return hash
  end

  def food_search(lat,lon)
    uri = "https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid=#{ENV['FOOD_SEARCH_APIKEY']}&latitude=#{lat}&longitude=#{lon}&range=5"
    json = get_search(uri)
    pro = Processor.new(json)
    hash = pro.line_extraction
    return hash
  end

  def get_search(uri)
    api = Api.new(URI.escape(uri))
    json = api.get
  end

  def keyword_sanitizing(keyword)
    keyword.gsub(/test|☆|【|】|%/,
                  "☆" => " ",
                  "【" => " ",
                  "】" => " ",
                  "%" => " "
                )
    return keyword
  end

end
