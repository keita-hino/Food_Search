class Command
  def get_help
    s = <<~EOS
      -------------本ボットの使い方-------------
      1.4種のアイコンの中から利用したいサービスを選択。
      2.位置情報を送信。

      -------------各種コマンド----------------
      $help
      →操作方法を表示

    EOS
    return s
  end

  def get_help_test
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
                      size: "xs",
                      weight: "bold",
                      gravity: "bottom",
                      color: "#666666"
                    }
                  ]
                },
                {
                  type: "box",
                  layout: "vertical",
                  contents: [
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
                      size: "xs",
                      weight: "bold",
                      color: "#666666"
                    }
                  ]
                },
                {
                  type: "box",
                  layout: "vertical",
                  contents: [
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
                      text: "送信ボタンを押下",
                      size: "xs",
                      weight: "bold",
                      color: "#666666"
                    }
                  ]
                },
                {
                  type: "box",
                  layout: "vertical",
                  contents: [
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
          }
        }]
      }
    }
  end
end
