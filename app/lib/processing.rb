

class Processer
  attr_accessor :json
  def initialize(json)
    @json = json
  end

  def extraction
    category = []
    buf = ""

    #LINEで送る文章作成
    for i in 0..count - 5
      buf << "店名：#{rest[i]["name"]}\n"
      buf << "URL：#{rest[i]["url_mobile"]}\n"
      buf << "ジャンル：#{rest[i]["category"]}\n"
      buf << "アクセス：#{rest[i]["address"]}\n\n"
    end

    return buf
  end

  def rest
    json["rest"]
  end

  def count
    json["hit_per_page"].to_i
  end
end
