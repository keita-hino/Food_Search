class LineJson
  # def get_json(name,category,store_uri,image_uri,address,opentime)
  #   buf_test = {
  #     type: "flex",
  #     altText: "this is a flex message",
  #     contents: {
  #       type: "carousel",
  #       contents: [
  #         {
  #         type: "bubble",
  #         hero: {
  #           type: "image",
  #           url: image_uri,
  #           size: "full",
  #           aspectRatio: "20:13"
  #         },
  #         body: {
  #           type: "box",
  #           layout: "vertical",
  #           contents: [
  #             {
  #               type: "text",
  #               text: name,
  #               weight: "bold",
  #               size: "xl"
  #             },
  #             {
  #               type: "box",
  #               layout: "baseline",
  #               margin: "md",
  #               # 星の評価の部分
  #               contents: [
  #                 {
  #                   type: "icon",
  #                   size: "sm",
  #                   url: "https://scdn.line-apps.com/n/channel_devcenter/img/fx/review_gold_star_28.png"
  #                 },
  #                 {
  #                   type: "icon",
  #                   size: "sm",
  #                   url: "https://scdn.line-apps.com/n/channel_devcenter/img/fx/review_gold_star_28.png"
  #                 },
  #                 {
  #                   type: "icon",
  #                   size: "sm",
  #                   url: "https://scdn.line-apps.com/n/channel_devcenter/img/fx/review_gold_star_28.png"
  #                 },
  #                 {
  #                   type: "icon",
  #                   size: "sm",
  #                   url: "https://scdn.line-apps.com/n/channel_devcenter/img/fx/review_gold_star_28.png"
  #                 },
  #                 {
  #                   type: "icon",
  #                   size: "sm",
  #                   url: "https://scdn.line-apps.com/n/channel_devcenter/img/fx/review_gray_star_28.png"
  #                 },
  #                 {
  #
  #                   type: "text",
  #                   text: "4.0",
  #                   size: "sm",
  #                   color: "#999999",
  #                   margin: "md",
  #                   flex: 0
  #                 }
  #               ]
  #             },
  #           {
  #             type: "box",
  #             layout: "vertical",
  #             margin: "lg",
  #             spacing: "sm",
  #             contents: [
  #               {
  #                 type: "box",
  #                 layout: "baseline",
  #                 spacing: "sm",
  #                 contents: [
  #                   {
  #                     type: "text",
  #                     text: "Place",
  #                     color: "#aaaaaa",
  #                     size: "sm",
  #                     flex: 1
  #                   },
  #                   {
  #                     type: "text",
  #                     text: address,
  #                     wrap: true,
  #                     color: "#666666",
  #                     size: "sm",
  #                     flex: 5
  #                   }
  #                 ]
  #               },
  #               {
  #                 type: "box",
  #                 layout: "baseline",
  #                 spacing: "sm",
  #                 contents: [
  #                   {
  #                     type: "text",
  #                     text: "Time",
  #                     color: "#aaaaaa",
  #                     size: "sm",
  #                     flex: 1
  #                   },
  #                   {
  #                     type: "text",
  #                     text: opentime,
  #                     wrap: true,
  #                     color: "#666666",
  #                     size: "sm",
  #                     flex: 5
  #                   }
  #                 ]
  #               }
  #             ]
  #           }
  #           ]
  #         },
  #         footer: {
  #           type: "box",
  #           layout: "vertical",
  #           contents: [
  #             {
  #               type: "button",
  #               style: "link",
  #               height: "sm",
  #                 action: {
  #                 type: "uri",
  #                 label: "WEBSITE",
  #                 uri: store_uri
  #               }
  #             }
  #           ]
  #         }
  #       }]
  #     }
  #   }
  # end

  def get_json(name,category,store_uri,image_uri,address,opentime)
    buf_test = {
      type: "flex",
      altText: "this is a flex message",
      contents: {
        type: "carousel",
        contents: [
          {
          type: "bubble",
          hero: {
            type: "image",
            url: image_uri,
            size: "full",
            aspectRatio: "20:13"
          },
          body: {
            type: "box",
            layout: "vertical",
            contents: [
              {
                type: "text",
                text: name,
                weight: "bold",
                size: "xl"
              },
              {
                type: "box",
                layout: "baseline",
                margin: "md",
                # 星の評価の部分
                contents: [
                  {
                    type: "icon",
                    size: "sm",
                    url: "https://scdn.line-apps.com/n/channel_devcenter/img/fx/review_gold_star_28.png"
                  },
                  {
                    type: "icon",
                    size: "sm",
                    url: "https://scdn.line-apps.com/n/channel_devcenter/img/fx/review_gold_star_28.png"
                  },
                  {
                    type: "icon",
                    size: "sm",
                    url: "https://scdn.line-apps.com/n/channel_devcenter/img/fx/review_gold_star_28.png"
                  },
                  {
                    type: "icon",
                    size: "sm",
                    url: "https://scdn.line-apps.com/n/channel_devcenter/img/fx/review_gold_star_28.png"
                  },
                  {
                    type: "icon",
                    size: "sm",
                    url: "https://scdn.line-apps.com/n/channel_devcenter/img/fx/review_gray_star_28.png"
                  },
                  {

                    type: "text",
                    text: "4.0",
                    size: "sm",
                    color: "#999999",
                    margin: "md",
                    flex: 0
                  }
                ]
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
                      text: address,
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
                      text: opentime,
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
                style: "link",
                height: "sm",
                  action: {
                  type: "uri",
                  label: "WEBSITE",
                  uri: store_uri
                }
              }
            ]
          }
        },
        {
        type: "bubble",
        hero: {
          type: "image",
          url: image_uri,
          size: "full",
          aspectRatio: "20:13"
        },
        body: {
          type: "box",
          layout: "vertical",
          contents: [
            {
              type: "text",
              text: name,
              weight: "bold",
              size: "xl"
            },
            {
              type: "box",
              layout: "baseline",
              margin: "md",
              # 星の評価の部分
              contents: [
                {
                  type: "icon",
                  size: "sm",
                  url: "https://scdn.line-apps.com/n/channel_devcenter/img/fx/review_gold_star_28.png"
                },
                {
                  type: "icon",
                  size: "sm",
                  url: "https://scdn.line-apps.com/n/channel_devcenter/img/fx/review_gold_star_28.png"
                },
                {
                  type: "icon",
                  size: "sm",
                  url: "https://scdn.line-apps.com/n/channel_devcenter/img/fx/review_gold_star_28.png"
                },
                {
                  type: "icon",
                  size: "sm",
                  url: "https://scdn.line-apps.com/n/channel_devcenter/img/fx/review_gold_star_28.png"
                },
                {
                  type: "icon",
                  size: "sm",
                  url: "https://scdn.line-apps.com/n/channel_devcenter/img/fx/review_gray_star_28.png"
                },
                {

                  type: "text",
                  text: "4.0",
                  size: "sm",
                  color: "#999999",
                  margin: "md",
                  flex: 0
                }
              ]
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
                    text: address,
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
                    text: opentime,
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
              style: "link",
              height: "sm",
                action: {
                type: "uri",
                label: "WEBSITE",
                uri: store_uri
              }
            }
          ]
        }
      }

      ]
      }
    }
  end

end
