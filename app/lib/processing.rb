

class Processer
  attr_accessor :json
  def initialize(json)
    @json = json
  end

  def extraction
    category = []
    buf = []

    # for i in 0..4
    #   buf[i] = {
    #     "name" => rest[i]["name"],
    #     "category" => rest[i]["category"],
    #     "url_mobile" => rest[i]["url_mobile"],
    #     "shop_image" => rest[i]["image_url"]["shop_image1"],
    #     "address" => rest[i]["address"],
    #     "opentime" => rest[i]["opentime"]
    #   }
    #   if buf[i]["shop_image"] == ""
    #     buf[i]["shop_image"] ='https://uds.gnst.jp/rest/img/mu3dgf0e0000/t_0n66.jpg'
    #   end
    # end

      buf[0] = {
        "name" => rest[0]["name"],
        "category" => rest[0]["category"],
        "url_mobile" => rest[0]["url_mobile"],
        "shop_image" => rest[0]["image_url"]["shop_image1"],
        "address" => rest[0]["address"],
        "opentime" => rest[0]["opentime"]
      }
      if buf[0]["shop_image"] == ""
        buf[0]["shop_image"] ='https://uds.gnst.jp/rest/img/mu3dgf0e0000/t_0n66.jpg'
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
