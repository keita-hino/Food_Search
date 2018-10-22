class Processing
  attr_accessor :json
  def initialize(json)
    @json = json
    @value
  end

  #yahooのAPIで取得したjsonを加工する
  def yahoo_extraction
    buf = []
    counter = 0

    # include(Fashion)
    # puts YAHOO_SITE_NAME
    # a = ActiveSupport::Dependencies.autoload_paths
    # a.each {|v| puts v}


    # SITE_KAGI = '【rakuten】'
    # SITE_NAME = '楽天ショッピング'

    if no_item?
      buf.push({
        site_name:  "Yahooショッピング",
        hit_flag:   false
      })
      return buf
    end

    #yahooのAPIのレスポンスに使わない項目があるため、削除
    remove_key

    get_yahoo_result.each do |key,value|
      counter += 1
      break if counter == 10
      @value = value
      buf.push({
        name:         get_yahoo_name,
        new_price:    get_yahoo_price,
        old_price:    "-",
        review_avg:   get_yahoo_review,
        review_count: get_yahoo_rcount,
        image_url:    get_yahoo_image,
        affi_url:     get_yahoo_url,
        site_kagi:  "【rakuten】",
        site_name:  "楽天ショッピング",
        hit_flag:   true
      })
    end
    return buf

  end

  def no_item?
     @json["ResultSet"]["0"]["Result"]["0"]["_attributes"]["index"] == "0"
  end

  def get_yahoo_result
    @json["ResultSet"]["0"]["Result"]
  end

  def get_yahoo_name
    @value["Name"]
  end

  def get_yahoo_price
    addcomma(@value["Price"]["_value"],3)
  end

  def get_yahoo_review
    @value["Review"]["Rate"]
  end

  def get_yahoo_rcount
    @value["Review"]["Count"]
  end

  def get_yahoo_image
    @value["Image"]["Medium"]
  end

  def get_yahoo_url
    @value["Url"]
  end

  # 金額関係のデータにカンマを入れる。
  def addcomma(num, sep)
    temp = num.to_s.reverse
    result = ""
    for i in 0..temp.length - 1
      if i % sep == 0 and i != 0
        result = "," + result
    end
      result = temp[i] + result
    end
    return "¥#{result}"
  end

  #yahooのAPIでgetした項目の中で不要なkeyを削除
  def remove_key
    @json["ResultSet"]["0"]["Result"].delete("Request")
    @json["ResultSet"]["0"]["Result"].delete("Modules")
    @json["ResultSet"]["0"]["Result"].delete("_container")
  end

  # 楽天のAPIで取得したjsonを加工する
  def rakuten_extraction
    buf = []
    counter = 0
    puts "😄#{rakuten_no_item?}"
    if rakuten_no_item?
      buf.push({
        site_name:  "楽天ショッピング",
        hit_flag:   false
      })
      return buf
    end

    parsed = @json["Products"]
    parsed.each do |value|
      counter += 1
      break if counter == 10
      @value = value
      buf.push({
        name:         get_name,
        review_avg:   get_review_avg,
        old_price:    get_old_price,
        new_price:    get_new_price,
        image_url:    get_image_url,
        affi_url:     get_affi_url,
        review_count: get_review_count,
        site_kagi:  "【yahoo】",
        site_name:  "Yahooショッピング",
        hit_flag:   true
      })
    end

    return buf

  end

  def rakuten_no_item?
    @json["Products"].blank?
  end

  def get_name
    @value["Product"]["productName"]
  end

  def get_review_avg
    @value["Product"]["reviewAverage"].to_f.to_s
  end

  def get_old_price
    "¥#{@value["Product"]["salesMinPrice"].to_s(:delimited)}"
  end

  def get_new_price
    "¥#{@value["Product"]["usedExcludeSalesMinPrice"].to_s(:delimited)}"
  end

  def get_image_url
    @value["Product"]["mediumImageUrl"].sub!(/\?.*/, "")
  end

  def get_affi_url
    @value["Product"]["affiliateUrl"]
  end

  def get_review_count
    @value["Product"]["reviewCount"].to_s
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

end
