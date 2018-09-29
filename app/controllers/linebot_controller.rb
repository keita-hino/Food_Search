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
          # message = {
          #   type: 'text',
          #   text: "testです"
          # }
        client.reply_message(event['replyToken'], {
        type: 'template',
        altText: 'Image carousel alt text',
        template: {
          type: 'image_carousel',
          columns: [
            {
              imageUrl: THUMBNAIL_URL,
              action: { label: 'line.me', type: 'uri', uri: 'https://line.me' }
            },
            {
              imageUrl: THUMBNAIL_URL,
              action: { label: 'postback', type: 'postback', data: 'hello world' }
            },
            {
              imageUrl: THUMBNAIL_URL,
              action: { label: 'message', type: 'message', text: 'This is message' }
            },
            {
              imageUrl: THUMBNAIL_URL,
              action: {
                type: 'datetimepicker',
                label: "Datetime",
                data: 'action=sel',
                mode: 'datetime',
                initial: '2017-06-18T06:15',
                max: '2100-12-31T23:59',
                min: '1900-01-01T00:00'
              }
            }
          ]
        }
      })
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
