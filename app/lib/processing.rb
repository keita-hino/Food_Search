
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

    j = 0
    for i in 0..count

      next if rest[i]["latitude"] == ""
      buf[j] = {
        "name" => rest[j]["name"],
        "category" => rest[j]["category"],
        "url_mobile" => rest[j]["url_mobile"],
        "shop_image" => rest[j]["image_url"]["shop_image1"],
        "address" => rest[j]["address"],
        "opentime" => rest[j]["opentime"],
        "latitude" => rest[j]["latitude"],
        "longitude" => rest[j]["longitude"]
      }
      if buf[j]["shop_image"] == ""
        buf[j]["shop_image"] = "https://food-line.herokuapp.com/no_image.png"
      end

      if buf[j]["opentime"] == ""
        buf[j]["opentime"] ='不明'
      end
      j = j + 1

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
