class LinebotController < ApplicationController
  require 'line/bot'  # gem 'line-bot-api'

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
          buf_test =  {
          "type": "flex",
          "altText": "hogehoge",
          "contents": {
              "type": "bubble",
              "styles": {
                  "header": {
                      "backgroundColor": "#ff62ae"
                  },
                  "body": {
                      "backgroundColor": "#5bff54"
                  },
                  "footer": {
                      "backgroundColor": "#7b78ff"
                  }
              },
              "header": {
                  "type": "box",
                  "layout": "vertical",
                  "contents": [
                      {
                          "type": "text",
                          "text": "header"
                      }
                  ]
              },
              "hero": {
                  "type": "image",
                  "url": "<imageUrl>",
                  "size": "full",
                  "aspectRatio": "1:1"
              },
              "body": {
                  "type": "box",
                  "layout": "vertical",
                  "contents": [
                      {
                          "type": "text",
                          "text": "body"
                      }
                  ]
              },
              "footer": {
                  "type": "box",
                  "layout": "vertical",
                  "contents": [
                      {
                          "type": "text",
                          "text": "footer"
                      }
                  ]
              }
          }
  }

          message = {
            type: 'text',
            text: buf_test
          }
          client.reply_message(event['replyToken'], message)
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
