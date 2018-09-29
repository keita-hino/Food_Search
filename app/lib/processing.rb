

class Processer
  attr_accessor :json
  def initialize(json)
    @json = json
  end

  def extraction
    category = []
    buf = []

    #LINEで送る文章作成
    # for i in 0..6
    #   buf << "店名：#{rest[i]["name"]}\n"
    #   buf << "ジャンル：#{rest[i]["category"]}\n"
    #   buf << "アクセス：#{rest[i]["address"]}\n"
    #   buf << "URL：#{rest[i]["url_mobile"]}\n\n"
    # end
    for i in 0..5
      buf[i] = {
        "name" => rest[i]["name"],
        "category" => rest[i]["category"],
        "url_mobile" => rest[i]["url_mobile"],
        "shop_image" => rest[i]["image_url"]["shop_image1"],
        "address" => rest[i]["address"],
        "opentime" => rest[i]["opentime"]
      }
      if buf[i]["shop_image"] == ""
        buf[i]["shop_image"] ='../assets/no_image.png'
      end
    end

    return buf
  end

  def rest
    json["rest"]
  end

  # def count
  #   json["hit_per_page"].to_i
  # end
end
