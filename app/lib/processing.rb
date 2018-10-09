
class Processer
  attr_accessor :json
  def initialize(json)
    @json = json
  end

  def extraction
    category = []
    buf = []

    range = (0..(json["total_hit_count"])).to_a

    # なぜかiが10以上になるとエラーになる。
    range.each do |i|

      break if i > 9
      next if rest[i]["latitude"] == ""
      if rest[i]["image_url"]["shop_image1"] == ""
        rest[i]["image_url"]["shop_image1"] = "https://food-line.herokuapp.com/no_image.png"
      end
      if rest[i]["opentime"] == ""
        rest[i]["opentime"] = '不明'
      end

      buf.push({
        name: rest[i]["name"],
        category: rest[i]["category"],
        url_mobile: rest[i]["url_mobile"],
        shop_image: rest[i]["image_url"]["shop_image1"],
        address: rest[i]["address"],
        opentime: rest[i]["opentime"],
        latitude: rest[i]["latitude"],
        longitude: rest[i]["longitude"]
      })

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
