class LinebotController < ApplicationController
  require 'line/bot'  # gem 'line-bot-api'
  THUMBNAIL_URL = 'https://via.placeholder.com/1024x1024'
  HORIZONTAL_THUMBNAIL_URL = 'https://via.placeholder.com/1024x768'
  QUICK_REPLY_ICON_URL = 'https://via.placeholder.com/64x64'

  # callbackアクションのCSRFトークン認証を無効
  protect_from_forgery :except => [:callback]

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

  def callback
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      error 400 do 'Bad Request' end
    end

    events = client.parse_events_from(body)
    # ただのテキストが送られたとき
    events.each { |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          # message = {
          #   type: 'text',
          #   text: "testです"
          # }
          buf_test = {
          contents: {
            type: "bubble",
            header: {
              type: "box",
              layout: "vertical",
              contents: [
                {
                  type: "text",
                  text: "Header text"
                }
              ]
            },
            hero: {
              type: "image",
              url: "https://scdn.line-apps.com/n/channel_devcenter/img/fx/01_2_restaurant.png",
              size: "full",
              aspectRatio: "4:3"
            },
            body: {
              type: "box",
              layout: "vertical",
              contents: [
                {
                  type: "店名",
                  text: "Body text",
                  size: "xl",
                  weight: "bold",
                }
              ]
            },
            footer: {
              type: "box",
              layout: "vertical",
              contents: [
                {
                  type: "text",
                  text: "Footer text",
                  align: "center",
                  color: "#888888"
                }
              ]
            }
          }
        }

        client.reply_message(event['replyToken'], buf_test)
        when Line::Bot::Event::MessageType::Location

          locate =<<~EOP
            住所:#{event.message['address']}
            緯度:#{event.message['latitude']}
            軽度:#{event.message['longitude'] }
          EOP

          lat = event.message['latitude']
          lon = event.message['longitude']
          reply_text = food_search(lat,lon)

          message = {
            type: 'text',
            text: reply_text
          }
          client.reply_message(event['replyToken'], message)
        end
      end
    }

    head :ok
  end

  def food_search(lat,lon)

    search = Searcher.new(lat.to_f,lon.to_f)
    json = search.get_info
    pro = Processer.new(json)
    return pro.extraction
  end

end
