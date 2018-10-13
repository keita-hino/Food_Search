class Processing
  attr_accessor :json
  def initialize(json)
    @json = json
  end

  # 楽天のAPIで取得したjsonを加工する
  def rakuten_extraction
    buf = []
    # puts 12345.to_s(:delimited)
    parsed = @json["Products"]
    parsed.each do |value|
      buf.push({
        name: value["Product"]["productName"],
        review_avg: value["Product"]["reviewAverage"].to_f.to_s,
        price: "¥#{value["Product"]["minPrice"].to_s(:delimited)}",
        image_url: value["Product"]["mediumImageUrl"].sub!(/\?.*/, ""),
        affi_url: value["Product"]["affiliateUrl"]
      })
    end
    return buf

  end

  def line_extraction
    category = []
    buf = []

    rest.each do |value|
      next if value["latitude"] == ""
      if value["image_url"]["shop_image1"] == ""
        value["image_url"]["shop_image1"] = "https://food-line.herokuapp.com/no_image.png"
      end
      if value["opentime"] == ""
        value["opentime"] = '不明'
      end
        buf.push({
          name: value["name"],
          category: value["category"],
          url_mobile: value["url_mobile"],
          shop_image: value["image_url"]["shop_image1"],
          address: value["address"],
          opentime: value["opentime"],
          latitude: value["latitude"],
          longitude: value["longitude"]
        })
    end

    return buf
  end

  def rest
    json["rest"]
  end

end
