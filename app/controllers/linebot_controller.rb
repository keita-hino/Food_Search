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
    user_id = events[0]["source"]["userId"]
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
            client.reply_message(event['replyToken'], message)
          when '$creater','製作者'
            message = c.get_creater
            client.reply_message(event['replyToken'], message)
          when '$search','商品検索'
            message = c.get_search_form
            client.reply_message(event['replyToken'], message)
          when '$record_show','過去に行った店'
            message = c.get_record_store_info(user_id)
            temp = c.get_record_store_info_temp(user_id)

            Temp.create(
              userid:user_id,
              payload:temp
            )
            client.reply_message(event['replyToken'], message)
          when /【rakuten】*/
            keyword = event.message['text']
            pat = /(【.*:)(.*】)(.*)/
            keyword =~ pat

            #楽天
            s = Searcher.new
            message = s.rakuten_search($3,$2.chop!)

            client.push_message(user_id, message)

          when /【yahoo】*/
            keyword = event.message['text']
            pat = /(【.*:)(.*】)(.*)/
            keyword =~ pat

            # Yahoo
            s = Searcher.new
            message = s.yahoo_search($3,$2.chop!)

            client.push_message(user_id, message)

          # マルチスレッド版
          when /【all】*/
            keyword = event.message['text']
            pat = /(【.*】)(.*)/
            keyword =~ pat
            _,raku_code,yahoo_code = $1.split(",")

            # 子プロセス作成
            pid = fork do
              #楽天
              s = Searcher.new
              raku_message = s.rakuten_search($2,raku_code)

              client.push_message(user_id, raku_message)
            end

            # 子プロセスの終了ステータス情報解放
            Process.detach(pid)

            # Yahoo
            s = Searcher.new
            yahoo_message = s.yahoo_search($2,yahoo_code.chop!)

            client.push_message(user_id, yahoo_message)

          when /【SHARE】/
            keyword = event.message['text']
            pat = /(【.*】)(.*)/
            keyword =~ pat

            users = Lineuser.all
            req = Request.new(
              client: client,
              users: users,
              share_name: $2
            )

            client.push_message(req.share_id, {
              type: "text",
              text: "#{req.my_name(user_id)}さんから過去に行った店をシェアされました。"
            })

            message = Temp.find_by_userid(user_id)

            client.push_message(req.share_id, message.payload)
            Temp.where(userid: user_id).delete_all

          else
            message = c.get_another_text(event.message['text'])
            client.reply_message(event['replyToken'], message)

          end

        when Line::Bot::Event::MessageType::Location
          lat = (event.message['latitude']).to_f
          lon = (event.message['longitude']).to_f

          s = Searcher.new
          message = s.food_search(lat,lon)

          client.reply_message(event['replyToken'], message)

        end

      when Line::Bot::Event::Follow
       lineuser = Lineuser.new(userid: user_id)
       lineuser.save

     # ブロックされた時の処理
     when Line::Bot::Event::Unfollow
       Lineuser.where(userid: user_id).delete_all

      when Line::Bot::Event::Postback
          case event['postback']['data']
          when "share"
            users = Lineuser.all
            req = Request.new(
              client: client,
              users: users
            )

            message = Command.share_reply(req.user_list)
          when /【rakuten】*/
            keyword = event['postback']['data']
            pat = /(【.*】)(.*)/
            keyword =~ pat

            #楽天
            s = Searcher.new
            message = s.rakuten_search($2)

          when /【yahoo】*/
            keyword = event['postback']['data']
            pat = /(【.*】)(.*)/
            keyword =~ pat

            # Yahoo
            s = Searcher.new
            message = s.yahoo_search($2)

          else
            array = event['postback']['data'].split(",")
            if array[0] == 'RECORD'
              restaurant = Restaurant.new(
                user_id: event["source"]["userId"],
                name: array[1],
                address: array[2],
                open_info: array[3],
                latitude: array[4],
                longitude: array[5],
                image_url: array[6],
                site_url: array[7],

              )
              restaurant.save
              message = {
                type: 'text',
                text: "【#{array[1]}】を保存したぞ！"
              }
            else
              message = {
                type:       "location",
                title:      array[0],
                address:    array[1],
                latitude:   array[2],
                longitude:  array[3]
              }
            end
          end
          client.reply_message(event['replyToken'], message)
      end
    }

    head :ok
  end
  def index
    @rakuten_list = EasySettings.rakuten_list
    @yahoo_list = EasySettings.yahoo_list
  end

end
