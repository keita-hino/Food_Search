class Command
  def get_creater
      a = {
        type: "text",
        text: "creater_info"
      }
  end

  def get_another_text(message)
    a = {
      type: "text",
      text: message
    }
  end

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
