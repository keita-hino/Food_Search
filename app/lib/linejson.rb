class Linejson

  def food_search(lat,lon)
    search = Searcher.new(lat,lon)
    json = search.get_food_json
    pro = Processing.new(json)

    return pro.line_extraction
  end

  def get_json(reply)
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
            url: reply[0][:shop_image],
            size: "full",
            aspectRatio: "20:13"
          },
          body: {
            type: "box",
            layout: "vertical",
            contents: [
              {
                type: "text",
                text: reply[0][:name],
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
                      text: reply[0][:address],
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
                      text: reply[0][:opentime],
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
                  data: "#{reply[0][:name]},#{reply[0][:address]},#{reply[0][:latitude]},#{reply[0][:longitude]}"
                }
              },
              {
                type: "button",
                style: "link",
                height: "sm",
                action: {
                  type: "uri",
                  label: "WEBSITE",
                  uri: reply[0][:url_mobile]
                }
              }
            ]
          }
        },
        #複数表示
        {
        type: "bubble",
        hero: {
          type: "image",
          url: reply[1][:shop_image],
          size: "full",
          aspectRatio: "20:13"
        },
        body: {
          type: "box",
          layout: "vertical",
          contents: [
            {
              type: "text",
              text: reply[1][:name],
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
                    text: reply[1][:address],
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
                    text: reply[1][:opentime],
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
                type: "postback",
                label: "ACCESS",
                data: "#{reply[1][:name]},#{reply[1][:address]},#{reply[1][:latitude]},#{reply[1][:longitude]}"
              }
            },
            {
              type: "button",
              style: "link",
              height: "sm",
                action: {
                type: "uri",
                label: "WEBSITE",
                uri: reply[1][:url_mobile]
              }
            }
          ]
        }
        },
        #複数表示
        {
        type: "bubble",
        hero: {
          type: "image",
          url: reply[2][:shop_image],
          size: "full",
          aspectRatio: "20:13"
        },
        body: {
          type: "box",
          layout: "vertical",
          contents: [
            {
              type: "text",
              text: reply[2][:name],
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
                    text: reply[2][:address],
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
                    text: reply[2][:opentime],
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
                type: "postback",
                label: "ACCESS",
                data: "#{reply[2][:name]},#{reply[2][:address]},#{reply[2][:latitude]},#{reply[2][:longitude]}"
              }
            },
            {
              type: "button",
              style: "link",
              height: "sm",
                action: {
                type: "uri",
                label: "WEBSITE",
                uri: reply[2][:url_mobile]
              }
            }
          ]
        }
        },
        #複数表示
        {
        type: "bubble",
        hero: {
          type: "image",
          url: reply[3][:shop_image],
          size: "full",
          aspectRatio: "20:13"
        },
        body: {
          type: "box",
          layout: "vertical",
          contents: [
            {
              type: "text",
              text: reply[3][:name],
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
                    text: reply[3][:address],
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
                    text: reply[3][:opentime],
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
                type: "postback",
                label: "ACCESS",
                data: "#{reply[3][:name]},#{reply[3][:address]},#{reply[3][:latitude]},#{reply[3][:longitude]}"
              }
            },
            {
              type: "button",
              style: "link",
              height: "sm",
              action: {
                type: "uri",
                label: "WEBSITE",
                uri: reply[3][:url_mobile]
              }
            }
          ]
        }
      },

      # 複数表示
      {
      type: "bubble",
      hero: {
        type: "image",
        url: reply[4][:shop_image],
        size: "full",
        aspectRatio: "20:13"
      },
      body: {
        type: "box",
        layout: "vertical",
        contents: [
          {
            type: "text",
            text: reply[4][:name],
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
                  text: reply[4][:address],
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
                  text: reply[4][:opentime],
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
              type: "postback",
              label: "ACCESS",
              data: "#{reply[4][:name]},#{reply[4][:address]},#{reply[4][:latitude]},#{reply[4][:longitude]}"
            }
          },
          {
            type: "button",
            style: "link",
            height: "sm",
              action: {
              type: "uri",
              label: "WEBSITE",
              uri: reply[4][:url_mobile]
            }
          }
        ]
      }
      }
      ]}
    }
  end

  ##jsonを動的に作るメソッド(現在作成中)
  # def get_json_advance(reply)
  #
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
  #           url: reply[0][:shop_image],
  #           size: "full",
  #           aspectRatio: "20:13"
  #         },
  #         body: {
  #           type: "box",
  #           layout: "vertical",
  #           contents: [
  #             {
  #               type: "text",
  #               text: reply[0][:name],
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
  #                     text: reply[0][:address],
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
  #                     text: reply[0][:opentime],
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
  #                 uri: reply[0][:url_mobile]
  #               }
  #             }
  #           ]
  #         }
  #       }
  #     ]}
  #   }
  #
  # end
end
