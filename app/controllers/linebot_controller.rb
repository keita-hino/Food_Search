class LinebotController < ApplicationController
  require 'line/bot'  # gem 'line-bot-api'
  THUMBNAIL_URL = 'https://via.placeholder.com/1024x1024'
  HORIZONTAL_THUMBNAIL_URL = 'https://scdn.line-apps.com/n/channel_devcenter/img/fx/01_2_restaurant.png'
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
          c = Command.new
          case event.message['text']
          when '$help','マニュアル','使い方'
            message = c.get_help
          when '$creater','製作者'
            message = c.get_creater
          else
            message = c.get_another_text(event.message['text'])
          end

        client.reply_message(event['replyToken'], message)
        when Line::Bot::Event::MessageType::Location

          lat = event.message['latitude']
          lon = event.message['longitude']

          line = LineJson.new
          reply = line.food_search(lat,lon)
          message = line.get_json(reply)

          ## デバッグ用
          # message = {
          #   type: 'text',
          #   text: params[:no]
          # }

          client.reply_message(event['replyToken'], message)
        end
      end
    }

    head :ok
  end

end
