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
          message = {
            type: 'text',
            text: "#{event.message['text']}"
          }

        image_uri = "https://uds.gnst.jp/rest/img/mu3dgf0e0000/t_0n66.jpg"
        # message = get_json(image_uri)
        client.reply_message(event['replyToken'], message)
        when Line::Bot::Event::MessageType::Location

          # locate =<<~EOP
          #   住所:#{event.message['address']}
          #   緯度:#{event.message['latitude']}
          #   軽度:#{event.message['longitude'] }
          # EOP

          lat = event.message['latitude']
          lon = event.message['longitude']
          reply = food_search(lat,lon)

          line = LineJson.new
          message = line.get_json(
            reply[0]["name"],
            reply[0]["category"],
            reply[0]["url_mobile"],
            reply[0]["shop_image"],
            reply[0]["address"],
            reply[0]["opentime"]
          )

          # message = {
          #   type: 'text',
          #   text: reply[0]["shop_image"]
          # }

          client.reply_message(event['replyToken'], message)
        end
      end
    }

    head :ok
  end

  def food_search(lat,lon)

    search = Searcher.new(lat.to_f,lon.to_f)
    json = search.get_food_json
    pro = Processer.new(json)

    return pro.extraction

  end

  def index

  end

  def show

  end

end
