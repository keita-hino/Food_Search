class Processing
  attr_accessor :json
  def initialize(json)
    @json = json
    @value
  end

  # 楽天のAPIで取得したjsonを加工する
  def rakuten_extraction
    buf = []
    counter = 0
    puts @json
    parsed = @json["Products"]
    parsed.each do |value|
      counter += 1
      break if counter == 10
      @value = value
      buf.push({
        name:       get_name,
        review_avg: get_review_avg,
        price:      get_price,
        image_url:  get_image_url,
        affi_url:   get_affi_url
      })
    end
    return buf

  end

  def get_name
    @value["Product"]["productName"]
  end

  def get_review_avg
    @value["Product"]["reviewAverage"].to_f.to_s
  end

  def get_price
    "¥#{@value["Product"]["minPrice"].to_s(:delimited)}"
  end

  def get_image_url
    @value["Product"]["mediumImageUrl"].sub!(/\?.*/, "")
  end

  def get_affi_url
    @value["Product"]["affiliateUrl"]
  end

  #リファクタリング用
  # ぐるなびAPIのレスポンスデータを加工する処理
  def line_extraction
    buf = []

    rest.each do |value|
      @value = value
      next if value["latitude"] == ""
      if value["image_url"]["shop_image1"] == ""
        value["image_url"]["shop_image1"] = "https://food-line.herokuapp.com/no_image.png"
      end
      if value["opentime"] == ""
        value["opentime"] = '不明'
      end
        buf.push({
          name:       get_rest_name,
          category:   get_category,
          url_mobile: get_url_mobile,
          shop_image: get_shop_image,
          address:    get_address,
          opentime:   get_opentime,
          latitude:   get_latitude,
          longitude:  get_longitude
        })
    end

    return buf
  end

  def rest
    json["rest"]
  end

  def get_rest_name
    @value["name"]
  end

  def get_category
    @value["category"]
  end

  def get_url_mobile
    @value["url_mobile"]
  end

  def get_shop_image
    @value["image_url"]["shop_image1"]
  end

  def get_address
    @value["address"]
  end

  def get_opentime
    @value["opentime"]
  end

  def get_latitude
    @value["latitude"]
  end

  def get_longitude
    @value["longitude"]
  end

  # def line_extraction
  #   buf = []
  #
  #   rest.each do |value|
  #     next if value["latitude"] == ""
  #     if value["image_url"]["shop_image1"] == ""
  #       value["image_url"]["shop_image1"] = "https://food-line.herokuapp.com/no_image.png"
  #     end
  #     if value["opentime"] == ""
  #       value["opentime"] = '不明'
  #     end
  #       buf.push({
  #         name: value["name"],
  #         category: value["category"],
  #         url_mobile: value["url_mobile"],
  #         shop_image: value["image_url"]["shop_image1"],
  #         address: value["address"],
  #         opentime: value["opentime"],
  #         latitude: value["latitude"],
  #         longitude: value["longitude"]
  #       })
  #   end
  #
  #   return buf
  # end
  #
  # def rest
  #   json["rest"]
  # end

end
