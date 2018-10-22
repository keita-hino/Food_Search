class Processor
  attr_accessor :json
  def initialize(json)
    @json = json
    @value
    extend(Search)
  end

  #yahooのAPIで取得したjsonを加工する
  def yahoo_extraction
    buf = []
    counter = 0

    if no_item?
      buf.push({
        site_name:  Search::YAHOO_SITE_NAME,
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
        site_kagi:  Search::RAKUTEN_SITE_KAGI,
        site_name:  Search::RAKUTEN_SITE_NAME,
        hit_flag:   true
      })
    end
    return buf

  end

  # 楽天のAPIで取得したjsonを加工する
  def rakuten_extraction
    buf = []
    counter = 0
    # extend(Search)
    if rakuten_no_item?
      buf.push({
        site_name:  Search::RAKUTEN_SITE_NAME,
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
        name:         get_rakuten_name,
        review_avg:   get_review_avg,
        old_price:    get_old_price,
        new_price:    get_new_price,
        image_url:    get_image_url,
        affi_url:     get_affi_url,
        review_count: get_review_count,
        site_kagi:  Search::YAHOO_SITE_KAGI,
        site_name:  Search::YAHOO_SITE_NAME,
        hit_flag:   true
      })
    end

    return buf

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

end
