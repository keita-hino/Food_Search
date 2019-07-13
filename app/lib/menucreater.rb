class Menucreater

  #LINEにPOSTするJSON作成
  def line_fashion_json(reply)
    if reply[0][:hit_flag] == false
      a = {
        type: "text",
        text: "この商品は#{reply[0][:site_name]}にないみたい・・・"
      }
      return a
    end
    a = {
      type: "flex",
      altText: "this is a flex message",
      contents: {
        type: "carousel",
        contents:
          reply.map do |json|
            {
            type: "bubble",
            hero: {
              type: "image",
              size: "full",
              aspectRatio: "20:13",
              url: json[:image_url]
            },
            body: {
              type: "box",
              layout: "vertical",
              contents: [
                {
                  type: "text",
                  text: json[:name],
                  wrap: true,
                  weight: "bold",
                  size: "md",
                  flex: 1
                },
                {
                  type: "box",
                  layout: "horizontal",
                  margin: "xl",
                  contents: [
                    {
                      type: "text",
                      text: "New Price",
                      color: "#aaaaaa",
                      size: "md",
                      align: "center",
                      flex: 1
                    },
                    {
                      type: "text",
                      text: json[:new_price],
                      wrap: true,
                      weight: "bold",
                      size: "md",
                      flex: 1
                    }
                  ]
                },
                {
                  type: "box",
                  layout: "horizontal",
                  margin: "lg",
                  contents: [
                    {
                      type: "text",
                      text: "Old Price",
                      color: "#aaaaaa",
                      size: "md",
                      align: "center",
                      flex: 1
                    },
                    {
                      type: "text",
                      text: json[:old_price],
                      wrap: true,
                      weight: "bold",
                      size: "md",
                      flex: 1
                    }
                  ]
                },
                {
                  type: "box",
                  layout: "horizontal",
                  margin: "lg",
                  contents: [
                    {
                      type: "text",
                      text: "　Review",
                      color: "#aaaaaa",
                      size: "md",
                      align: "center",
                      flex: 1
                    },
                    {
                      type: "text",
                      text: json[:review_avg] + " (#{json[:review_count]}件)",
                      wrap: true,
                      weight: "bold",
                      size: "md",
                      flex: 1
                    }
                  ]
                }
              ]
            },
            footer: {
              type: "box",
              layout: "vertical",
              spacing: "sm",
              contents:
              [
                {
                  type: "button",
                  style: "primary",
                  action: {
                    type: "uri",
                    label: "これにする！",
                    uri: json[:affi_url]
                  }
                },
                  {
                    type: "button",
                    action: {
                      type: "postback",
                      label: "#{json[:site_name]}と比較",
                      data: "#{json[:site_kagi]}#{json[:name]}"
                    }
                  }
                ]
              }
            }
          end
        }
      }
  end

  #LINEにPOSTするJSON作成
  def get_json(reply)
    buf_test = {
      type: "flex",
      altText: "this is a flex message",
      contents: {
        type: "carousel",
        contents:
        reply.map do |json|
          if json[:opentime].length > 50
            json[:opentime] = json[:opentime].slice(0,50)
          end
          {
          type: "bubble",
          hero: {
            type: "image",
            url: json[:shop_image],
            size: "full",
            aspectRatio: "20:13"
          },
          body: {
            type: "box",
            layout: "vertical",
            contents: [
              {
                type: "text",
                text: json[:name],
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
                      text: json[:address],
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
                      text: json[:opentime],
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
                  data: "#{json[:name]},#{json[:address]},#{json[:latitude]},#{json[:longitude]}"
                }
              },
              {
                type: "button",
                style: "link",
                height: "sm",
                action: {
                  type: "uri",
                  label: "WEBSITE",
                  uri: json[:url_mobile]
                }
              },
              {
                type: "button",
                style: "link",
                height: "sm",
                action: {
                  type: "postback",
                  label: "RECORD",
                  data: "RECORD,#{json[:name]},#{json[:address]},#{json[:opentime]},#{json[:latitude]},#{json[:longitude]},#{json[:shop_image]},#{json[:url_mobile]}"
                }
              }
              ]
            }
          }
        end
      }
    }
  end

end
