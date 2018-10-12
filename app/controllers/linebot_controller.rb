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
          c = Command.new
          case event.message['text']
          when '$help','マニュアル','使い方'
            message = c.get_help
          when '$creater','製作者'
            message = c.get_creater
          when '$search','商品検索'
            message = c.get_search_form
          when /【商品検索】*/
            keyword = event.message['text']
            keyword.slice!(0..5)
            r = Rakutenjson.new
            message = r.fashion_search(keyword)
            puts message
          else
            message = c.get_another_text(event.message['text'])
          end

        client.reply_message(event['replyToken'], message)
        when Line::Bot::Event::MessageType::Location

          lat = (event.message['latitude']).to_f
          lon = (event.message['longitude']).to_f

          line = Linejson.new
          reply = line.food_search(lat,lon)
          message = line.get_json(reply)

          # デバッグ用
          # message = {
          #   type: 'text',
          #   text: "test"
          # }


          client.reply_message(event['replyToken'], message)

        end
      when Line::Bot::Event::Postback
          array = event['postback']['data'].split(",")
          message = {
            type: "location",
            title: array[0],
            address: array[1],
            latitude:  array[2],
            longitude:  array[3]
          }
            client.reply_message(event['replyToken'], message)
      end
    }

    head :ok
  end
  def index

  end

end
