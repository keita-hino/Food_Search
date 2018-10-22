class Rakutenjson

  def fashion_search(keyword)
    s = Searcher.new
    re_keyword = s.keyword_sanitizing(keyword)
    uri = "https://app.rakuten.co.jp/services/api/Product/Search/20170426?format=json&keyword=#{re_keyword}&applicationId=#{ENV['RAKUTEN_APPLICATION_ID']}&affiliateId=#{ENV['RAKUTEN_AFFILIATE_ID']}"
    json = s.get_search(uri)

    pro = Processing.new(json)
    line_json = Linejson.new
    hash = pro.rakuten_extraction
    message = line_json.line_fashion_json(hash)
    reply = JSON.generate(message)
    return eval(reply)
  end

end
