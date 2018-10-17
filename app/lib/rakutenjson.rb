class Rakutenjson
  def fashion_search(pro_name)
    s = Searcher.new
    json = s.get_rakuten_info(pro_name)
    pro = Processing.new(json)
    hash = pro.rakuten_extraction
    message = line_post_json_test(hash)
    reply = JSON.generate(message)
    puts reply
    return eval(reply)

  end

  #LINEにPOSTするJSON作成
  def line_post_json_test(reply)
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
                      text: json[:review_avg] + " (2件)",
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
                      type: "uri",
                      label: "他のショッピングサイトと比較",
                      uri: "https://linecorp.com"
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
