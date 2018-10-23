class Searcher

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
