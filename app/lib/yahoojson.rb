class Yahoojson

  def fashion_search(code='999',keyword)
    s = Searcher.new

    re_keyword = s.keyword_sanitizing(keyword)
    uri = "http://shopping.yahooapis.jp/ShoppingWebService/V1/json/itemSearch?appid=#{ENV['YAHOO_APP_ID']}&query=#{re_keyword}&sort=-review_count&image_size=76"
    json = s.get_search(uri)
    pro = Processor.new(json)
    line_json = Linejson.new
    hash = pro.yahoo_extraction
    message = line_json.line_fashion_json(hash)
    reply = JSON.generate(message)
    return eval(reply)
  end

end
