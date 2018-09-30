

class Processer
  attr_accessor :json
  def initialize(json)
    @json = json
  end

  def extraction
    category = []
    buf = []
    if json["total_hit_count"].to_i <= 5
      count = json["total_hit_count"].to_i
    else
      count = 4
    end

    for i in 0..count
      buf[i] = {
        "name" => rest[i]["name"],
        "category" => rest[i]["category"],
        "url_mobile" => rest[i]["url_mobile"],
        "shop_image" => rest[i]["image_url"]["shop_image1"],
        "address" => rest[i]["address"],
        "opentime" => rest[i]["opentime"]
      }
      if buf[i]["shop_image"] == ""
        buf[i]["shop_image"] ='https://uds.gnst.jp/rest/img/mu3dgf0e0000/t_0n66.jpg'
      end

      if buf[i]["opentime"] == ""
        buf[i]["opentime"] ='不明'
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
