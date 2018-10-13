class Rakutenjson
  def fashion_search(pro_name)
    s = Searcher.new
    json = s.get_rakuten_info(pro_name)
    pro = Processing.new(json)
    hash = pro.rakuten_extraction
    message = line_post_json_test(hash)

    #lineでメッセージを送るメソッドでハッシュかどうかチェックしている処理があるため、
    #Hash形式煮直す。
    return eval(message)
  end

  def line_post_json_test(reply)
    a =<<~EOF
    {
      type: "flex",
      altText: "this is a flex message",
      contents: {
        type: "carousel",
        contents: [
    EOF
    reply.each_with_index do |key,i|
      unless i == 0
        a << "},"
      end
      a <<<<~EOF
              {
              type: "bubble",
              hero: {
                type: "image",
                size: "full",
                aspectRatio: "20:13",
                url: '#{key[:image_url]}'
              },
              body: {
                type: "box",
                layout: "vertical",
                contents: [
                  {
                    type: "text",
                    text: '#{key[:name]}',
                    wrap: true,
                    weight: "bold",
                    size: "md",
                    flex: 1
                  },
                  {
                    type: "box",
                    layout: "horizontal",
                    margin: "lg",
                    contents: [
                      {
                        type: "text",
                        text: "Place",
                        color: "#aaaaaa",
                        size: "md",
                        flex: 1
                      },
                      {
                        type: "text",
                        text: '#{key[:price]}',
                        wrap: true,
                        weight: "bold",
                        size: "md",
                        flex: 3
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
                        text: "Review",
                        color: "#aaaaaa",
                        size: "md",
                        flex: 1
                      },
                      {
                        type: "text",
                        text: '#{key[:review_avg]}',
                        wrap: true,
                        weight: "bold",
                        size: "md",
                        flex: 3
                      }
                    ]
                  }
                ]
              },
              footer: {
                type: "box",
                layout: "vertical",
                spacing: "sm",
                contents: [
                  {
                    type: "button",
                    style: "primary",
                    action: {
                      type: "uri",
                      label: "これにする！",
                      uri: '#{key[:affi_url]}'
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

          EOF
          if i == 9
            break
          end

    end
    a <<<<~EOF
                }
              ]
            }
          }

    EOF

  end

end
