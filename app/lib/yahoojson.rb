class Yahoojson

  def fashion_search(pro_name)
    s = Searcher.new
    json = s.get_yahoo_info(pro_name)
    pro = Processing.new(json)
    line_json = Linejson.new
    hash = pro.yahoo_extraction
    message = line_json.line_fashion_json(hash)
    reply = JSON.generate(message)
    return eval(reply)
  end

end
