class Command
  def get_creater
    buf = Hash.new
    buf[:type] = "text"
    buf[:text] = "creater_info"
    return buf
  end

  def get_another_text(message)
    buf = Hash.new
    buf[:type] = "text"
    buf[:text] = message
    return buf
  end

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
                    uri: "line://app/1609459955-0Aw3AXjZ"
                  }
                }
              ]
            }
          ]
        }
      }
    }
  end

  # def get_help_test
  #   buf = Hash.new
  #   buf["type"] = "flex"
  #   buf["altText"] = "this is a flex message"
  #   buf["contents"] = Hash.new
  #   buf["contents"]["type"] = "carousel"
  #   buf["contents"]["contents"][0] = Hash.new
  #   buf["contents"]["contents"][0]["type"] = "bubble"
  #   buf["contents"]["contents"][0]["header"] = Hash.new
  #   buf["contents"]["contents"][0]["header"]["type"] = "box"
  #   buf["contents"]["contents"][0]["header"]["layout"] = "vertical"
  #   buf["contents"]["contents"][0]["header"]["layout"]["contents"] = Hash.new
  #
  #
  # end
  #
  # def contents
  #   ["contents"]
  # end

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
