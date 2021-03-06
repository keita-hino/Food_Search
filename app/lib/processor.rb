class Processor
  # attr_accessor :json
  attr_reader :manu, :json
  def initialize(json)
    @json = json
    @manu = Menucreater.new
    extend(Extraction)
  end

  #yahooのAPIで取得したjsonを加工する
  def yahoo_extraction
    buf = []
    counter = 0

    if no_item?
      buf.push({
        site_name: Extraction::YAHOO_SITE_NAME,
        hit_flag:  false
      })
      return manu.line_fashion_json(buf)
    end

    #yahooのAPIのレスポンスに使わない項目があるため、削除
    remove_key

    yahoo_result.each do |key,value|
      counter += 1
      break if counter == Extraction::FLEX_MAX_PAGE
      @value = value
      buf.push({
        name:         yahoo_name,
        new_price:    yahoo_price,
        old_price:    Extraction::NO_ITEM_SYMBLE,
        review_avg:   yahoo_review,
        review_count: yahoo_rcount,
        image_url:    yahoo_image,
        affi_url:     yahoo_url,
        site_kagi:    Extraction::RAKUTEN_SITE_KAGI,
        site_name:    Extraction::RAKUTEN_SITE_NAME,
        hit_flag:     true
      })
    end

    return eval(reply_message(buf))

  end

  # 楽天のAPIで取得したjsonを加工する
  def rakuten_extraction
    buf = []
    counter = 0

    if rakuten_no_item?
      buf.push({
        site_name: Extraction::RAKUTEN_SITE_NAME,
        hit_flag:  false
      })
      return manu.line_fashion_json(buf)
    end

    products.each do |value|
      @value = value
      next if rakuten_no_stock?
      counter += 1
      break if counter == Extraction::FLEX_MAX_PAGE

      buf.push({
        name:         rakuten_name,
        review_avg:   review_avg,
        old_price:    old_price,
        new_price:    new_price,
        image_url:    image_url,
        affi_url:     affi_url,
        review_count: review_count,
        site_kagi:    Extraction::YAHOO_SITE_KAGI,
        site_name:    Extraction::YAHOO_SITE_NAME,
        hit_flag:     true
      })
    end

    if buf.empty?
      buf.push({
        site_name: Extraction::RAKUTEN_SITE_NAME,
        hit_flag:  false
      })
    end

    return eval(reply_message(buf))
  end

  # リファクタリング用
  # ぐるなびAPIのレスポンスデータを加工する処理
  def line_extraction
    buf = []

    rest.each do |value|
      @value = value
      next if latitude_empty?
        buf.push({
          name:       rest_name,
          category:   category,
          url_mobile: url_mobile,
          shop_image: shop_image,
          address:    address,
          opentime:   opentime,
          latitude:   latitude,
          longitude:  longitude
        })
    end
    return manu.get_json(buf)

  end

  def reply_message(buf)
    message = manu.line_fashion_json(buf)
    reply = JSON.generate(message)
  end

end
