module Extraction

  YAHOO_SITE_NAME = "Yahooショッピング"
  YAHOO_SITE_KAGI = "【yahoo】"
  RAKUTEN_SITE_NAME = "楽天ショッピング"
  RAKUTEN_SITE_KAGI = "【rakuten】"
  NO_ITEM_SYMBLE = "-"
  FLEX_MAX_PAGE = 10

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

  # Yahoo用のメソッド
  def no_item?
     @json["ResultSet"]["0"]["Result"]["0"]["_attributes"]["index"] == "0"
  end

  def yahoo_result
    @json["ResultSet"]["0"]["Result"]
  end

  def yahoo_name
    @value["Name"]
  end

  def yahoo_price
    addcomma(@value["Price"]["_value"],3)
  end

  def yahoo_review
    @value["Review"]["Rate"]
  end

  def yahoo_rcount
    @value["Review"]["Count"]
  end

  def yahoo_image
    @value["Image"]["Medium"]
  end

  def yahoo_url
    @value["Url"]
  end

  # 楽天用のメソッド
  def rakuten_no_item?
    @json["Products"].blank?
  end

  def rakuten_no_stock?
    @value["Product"]["salesItemCount"].zero?
  end

  def rakuten_name
    @value["Product"]["productName"]
  end

  def review_avg
    @value["Product"]["reviewAverage"].to_f.to_s
  end

  def old_price
    addcomma(@value["Product"]["salesMinPrice"],3)
  end

  def new_price
    addcomma(@value["Product"]["usedExcludeSalesMinPrice"],3)
  end

  def image_url
    @value["Product"]["mediumImageUrl"].sub!(/\?.*/, "")
  end

  def affi_url
    @value["Product"]["affiliateUrl"]
  end

  def review_count
    @value["Product"]["reviewCount"].to_s
  end

  def products
    @json["Products"]
  end

  # ぐるなび用のメソッド
  def rest
    @json["rest"]
  end

  def rest_name
    @value["name"]
  end

  def category
    @value["category"]
  end

  def url_mobile
    @value["url_mobile"]
  end

  def shop_image
    if @value["image_url"]["shop_image1"].empty?
      @value["image_url"]["shop_image1"] = "https://food-line.herokuapp.com/no_image.png"
    else
      @value["image_url"]["shop_image1"]
    end
  end

  def address
    @value["address"]
  end

  def opentime
    if @value["opentime"].empty?
      @value["opentime"] = '不明'
    else
      @value["opentime"]
    end
  end

  def latitude
    @value["latitude"]
  end

  def longitude
    @value["longitude"]
  end

  def latitude_empty?
    @value["latitude"].empty?
  end

end
