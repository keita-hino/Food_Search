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
          message = {
            type: 'text',
            text: "#{event.message['text']}[テスト用です]"
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
          # reply_text = food_search(lat,lon)

          search = Searcher.new(lat.to_i,lon.to_i)
          json = search.get_info
          pro = Processer.new(json)
          a = pro.extraction


          message = {
            type: 'text',
            text: a
          }
          client.reply_message(event['replyToken'], message)
        end
      end
    }

    head :ok
  end

  # def food_search(lat,lon)
  #   # latitude = 38.444207
  #   # longitude = 141.288718
  #
  #   # search = Searcher.new(lat.to_i,lon.to_i)
  #   # json = search.get_info
  #   # pro = Processer.new(json)
  #   return pro.extraction
  # end

end
