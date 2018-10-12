class Rakutenjson
  def fashion_search(pro_name)
    s = Searcher.new
    json = s.get_rakuten_info(pro_name)
    pro = Processing.new(json)
    hash = pro.rakuten_extraction
    return line_post_json(hash)
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
        a << ","
      end
      a <<<<~EOF
              {
              type: "bubble",
              hero: {
                type: "image",
                size: "full",
                aspectRatio: "20:13",
                aspectMode: "cover",
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
            }
          EOF
          if i == 2
            break
          end

    end
    a <<<<~EOF
              ]
            }
          }

    EOF

    return a

  end

  def line_post_json(reply)
    puts "(検索用)#{reply[0][:image_url]}"
    a = {
        type: "flex",
        altText: "this is a flex message",
        contents: {
          type: "carousel",
          contents: [
            {
              type: "bubble",
              hero: {
                type: "image",
                size: "full",
                aspectRatio: "20:13",
                aspectMode: "cover",
                url: reply[0][:image_url]
              },
              body: {
                type: "box",
                layout: "vertical",
                contents: [
                  {
                    type: "text",
                    text: reply[0][:name],
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
                        text: reply[0][:price],
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
                        text: reply[0][:review_avg].to_s,
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
                      uri: reply[0][:affi_url]
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
            },
            {
              type: "bubble",
              hero: {
                type: "image",
                size: "full",
                aspectRatio: "20:13",
                aspectMode: "cover",
                url: reply[1][:image_url]
              },
              body: {
                type: "box",
                layout: "vertical",
                contents: [
                  {
                    type: "text",
                    text: reply[1][:name],
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
                        text: reply[1][:price],
                        wrap: true,
                        weight: "bold",
                        size: "md",
                        flex: 4
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
                        text: reply[1][:review_avg],
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
                      uri: reply[1][:affi_url]
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
            },
            {
              type: "bubble",
              hero: {
                type: "image",
                size: "full",
                aspectRatio: "20:13",
                aspectMode: "cover",
                url: reply[2][:image_url]
              },
              body: {
                type: "box",
                layout: "vertical",
                contents: [
                  {
                    type: "text",
                    text: reply[2][:name],
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
                        text: reply[2][:price],
                        wrap: true,
                        weight: "bold",
                        size: "md",
                        flex: 4
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
                        text: reply[2][:review_avg],
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
                      uri: reply[2][:affi_url]
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
            },
            {
              type: "bubble",
              hero: {
                type: "image",
                size: "full",
                aspectRatio: "20:13",
                aspectMode: "cover",
                url: reply[3][:image_url]
              },
              body: {
                type: "box",
                layout: "vertical",
                contents: [
                  {
                    type: "text",
                    text: reply[3][:name],
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
                        text: reply[3][:price],
                        wrap: true,
                        weight: "bold",
                        size: "md",
                        flex: 4
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
                        text: reply[3][:review_avg],
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
                      uri: reply[3][:affi_url]
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
            },
            {
              type: "bubble",
              hero: {
                type: "image",
                size: "full",
                aspectRatio: "20:13",
                aspectMode: "cover",
                url: reply[4][:image_url]
              },
              body: {
                type: "box",
                layout: "vertical",
                contents: [
                  {
                    type: "text",
                    text: reply[4][:name],
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
                        text: reply[4][:price],
                        wrap: true,
                        weight: "bold",
                        size: "md",
                        flex: 4
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
                        text: reply[4][:review_avg],
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
                      uri: reply[4][:affi_url]
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
          ]
        }
      }

  end

end
