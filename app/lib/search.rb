module Search

  YAHOO_SITE_NAME = "Yahooショッピング"
  YAHOO_SITE_KAGI = "【yahoo】"
  RAKUTEN_SITE_NAME = "楽天ショッピング"
  RAKUTEN_SITE_KAGI = "【rakuten】"

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

  # 楽天用のメソッド
  def rakuten_no_item?
    @json["Products"].blank?
  end

  def get_rakuten_name
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

  # ぐるなび用のメソッド
  def rest
    @json["rest"]
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
