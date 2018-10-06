
class Processer
  attr_accessor :json
  def initialize(json)
    @json = json
  end

  def extraction
    category = []
    buf = []
    if json["total_hit_count"].to_i <= 5
      count = json["total_hit_count"].to_i - 1
    else
      count = 4
    end

    for i in 0..count
      next if rest[i]["latitude"] == ""
      buf[i] = {
        "name" => rest[i]["name"],
        "category" => rest[i]["category"],
        "url_mobile" => rest[i]["url_mobile"],
        "shop_image" => rest[i]["image_url"]["shop_image1"],
        "address" => rest[i]["address"],
        "opentime" => rest[i]["opentime"],
        "latitude" => rest[i]["latitude"],
        "longitude" => rest[i]["longitude"]
      }
      if buf[i]["shop_image"] == ""
        buf[i]["shop_image"] = "https://food-line.herokuapp.com/no_image.png"
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
