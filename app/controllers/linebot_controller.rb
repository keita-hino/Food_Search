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
          user_id = event["source"]["userId"]
          case event.message['text']
          when '$help','マニュアル','使い方'
            message = c.get_help
            client.reply_message(event['replyToken'], message)
          when '$creater','製作者'
            message = c.get_creater
            client.reply_message(event['replyToken'], message)
          when '$search','商品検索'
            message = c.get_search_form
            client.reply_message(event['replyToken'], message)
          when /【rakuten】*/
            keyword = event.message['text']
            pat = /(【.*:)(.*】)(.*)/
            keyword =~ pat

            #楽天
            r = Rakutenjson.new
            message = r.fashion_search($2.chop!,$3)

            client.push_message(user_id, message)

          when /【yahoo】*/
            keyword = event.message['text']
            pat = /(【.*:)(.*】)(.*)/
            keyword =~ pat

            # Yahoo
            y = Yahoojson.new
            message = y.fashion_search($2.chop!,$3)

            client.push_message(user_id, message)

          when /【all】*/
            keyword = event.message['text']
            pat = /(【.*】)(.*)/
            keyword =~ pat
            _,raku_code,yahoo_code = $1.split(",")

            #楽天
            r = Rakutenjson.new
            raku_message = r.fashion_search(raku_code,$2)

            client.push_message(user_id, raku_message)

            # Yahoo
            y = Yahoojson.new
            yahoo_message = y.fashion_search(yahoo_code.chop!,$2)

            client.push_message(user_id, yahoo_message)

          else
            message = c.get_another_text(event.message['text'])
            client.reply_message(event['replyToken'], message)
          end

        when Line::Bot::Event::MessageType::Location

          lat = (event.message['latitude']).to_f
          lon = (event.message['longitude']).to_f

          line = Linejson.new
          reply = line.food_search(lat,lon)
          message = line.get_json_test(reply)

          # デバッグ用
          # message = {
          #   type: 'text',
          #   text: "test"
          # }

          client.reply_message(event['replyToken'], message)

        end
      when Line::Bot::Event::Postback
          case event['postback']['data']
          when /【rakuten】*/
            keyword = event['postback']['data']
            pat = /(【.*】)(.*)/
            keyword =~ pat

            #楽天
            r = Rakutenjson.new
            message = r.fashion_search($2)

          when /【yahoo】*/
            keyword = event['postback']['data']
            pat = /(【.*】)(.*)/
            keyword =~ pat

            # Yahoo
            y = Yahoojson.new
            message = y.fashion_search($2)

          else
            array = event['postback']['data'].split(",")
            message = {
              type: "location",
              title: array[0],
              address: array[1],
              latitude:  array[2],
              longitude:  array[3]
            }
          end

          # puts event['postback']['data']
            client.reply_message(event['replyToken'], message)
      end
    }

    head :ok
  end
  def index

  end

end
