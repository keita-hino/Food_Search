class Command

  #作成者の情報を取得(未実装)
  def get_creater
    buf = Hash.new
    buf[:type] = "text"
    buf[:text] = "creater_info"
    return buf
  end

  #想定していないメッセージが送られた場合はオウム返し
  def get_another_text(message)
    buf = Hash.new
    buf[:type] = "text"
    buf[:text] = message
    return buf
  end

  #liffのURLを送信
  def get_search_form
    {
      type: "flex",
      altText: "this is a flex message",
      contents: {
        type: "bubble",
        body: {
          type: "box",
          layout: "vertical",
          contents: [
            {
              type: "text",
              text: "検索したい商品を入力してください",
              weight: "bold",
              size: "md",
              wrap: true
            },
            {
              type: "box",
              layout: "vertical",
              margin: "md",
              contents: [
                {
                  type: "button",
                  style: "link",
                  height: "sm",
                  action: {
                    type: "uri",
                    label: "商品検索画面へ",
                    uri: ENV['LIFF_URL']
                  }
                }
              ]
            }
          ]
        }
      }
    }
  end

  def get_record_store_info(user_id)

    restaurants = Restaurant.user_id_is(user_id).limit(10)

    buf_test = {
      type: "flex",
      altText: "this is a flex message",
      contents: {
        type: "carousel",
        contents:
        restaurants.map do |restaurant|
          {
          type: "bubble",
          hero: {
            type: "image",
            url: restaurant.image_url,
            size: "full",
            aspectRatio: "20:13"
          },
          body: {
            type: "box",
            layout: "vertical",
            contents: [
              {
                type: "text",
                text: restaurant.name,
                weight: "bold",
                size: "xl"
              },
            {
              type: "box",
              layout: "vertical",
              margin: "lg",
              spacing: "sm",
              contents: [
                {
                  type: "box",
                  layout: "baseline",
                  spacing: "sm",
                  contents: [
                    {
                      type: "text",
                      text: "Place",
                      color: "#aaaaaa",
                      size: "sm",
                      flex: 1
                    },
                    {
                      type: "text",
                      text: restaurant.address.blank? ? "no info" : restaurant.address,
                      wrap: true,
                      color: "#666666",
                      size: "sm",
                      flex: 5
                    }
                  ]
                },
                {
                  type: "box",
                  layout: "baseline",
                  spacing: "sm",
                  contents: [
                    {
                      type: "text",
                      text: "Time",
                      color: "#aaaaaa",
                      size: "sm",
                      flex: 1
                    },
                    {
                      type: "text",
                      text: restaurant.open_info.blank? ? "no info" : restaurant.open_info,
                      wrap: true,
                      color: "#666666",
                      size: "sm",
                      flex: 5
                    }
                  ]
                }
              ]
            }
            ]
          },
          footer: {
            type: "box",
            layout: "vertical",
            contents: [
              {
                type: "button",
                height: "sm",
                action: {
                  type: "postback",
                  label: "ACCESS",
                  data: "#{restaurant.name},#{restaurant.address},#{restaurant.latitude},#{restaurant.longitude}"
                }
              },
              {
                type: "button",
                style: "link",
                height: "sm",
                action: {
                  type: "uri",
                  label: "WEBSITE",
                  uri: restaurant.site_url
                }
              }
              ]
            }
          }
        end
      }
    }
  end

  #help画面表示
  def get_help
    a = {
      type: "flex",
      altText: "this is a flex message",
      contents: {
        type: "carousel",
        contents: [
          {
            type: "bubble",
            header: {
              type: "box",
              layout: "vertical",
              contents: [
                {
                  type: "text",
                  text: "help",
                  weight: "bold",
                  color: "#aaaaaa",
                  size: "xl"
                }
              ]
            },
            body: {
              type: "box",
              spacing: "xxl",
              layout: "vertical",
              contents: [
                {
                  type: "box",
                  layout: "vertical",
                  contents: [
                    {
                      type: "text",
                      text: "下記のアイコンを押下",
                      size: "sm",
                      weight: "bold",
                      gravity: "bottom",
                      color: "#00bfff"
                    },
                    {
                      type: "image",
                      url: "https://food-line.herokuapp.com/man1.png",
                      aspectMode: "cover",
                      aspectRatio: "20:13",
                      gravity: "top",
                      size: "full"
                    }
                  ]
                },
                {
                  type: "box",
                  layout: "vertical",
                  contents: [
                    {
                      type: "text",
                      text: "「この位置を送信」を押下",
                      size: "sm",
                      weight: "bold",
                      color: "#00bfff"
                    },
                    {
                      type: "image",
                      url: "https://food-line.herokuapp.com/man2.png",
                      aspectMode: "cover",
                      aspectRatio: "3:4",
                      size: "full"
                    }
                  ]
                },
                {
                  type: "box",
                  layout: "vertical",
                  contents: [
                    {
                      type: "text",
                      text: "「送信」を押下",
                      size: "sm",
                      weight: "bold",
                      color: "#00bfff"
                    },
                    {
                      type: "image",
                      url: "https://food-line.herokuapp.com/man3.png",
                      aspectMode: "cover",
                      aspectRatio: "3:4",
                      size: "full"
                    }
                  ]
                }
              ]
            }
          }]
        }
      }
  end
end
