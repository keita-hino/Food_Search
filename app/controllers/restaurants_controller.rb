class RestaurantsController < ApplicationController
  def index
    @restaurant = Restaurant.new
    @restaurants = Restaurant.user_uid_is(current_user.uid)
                             .order('updated_at desc')

    @users = Request.new(
            client: client,
            users: Lineuser.all
          ).user_list

  end

  def create
    # TODO:画像とかどうするか検討
    @restaurant = Restaurant.new(restaurant_params)
    # TODO:エラー処理追加
    if @restaurant.save

    else

    end
    render partial: 'restaurants/modal/new'
  end

  def share
    restaurants = Restaurant.order(id: 'desc').limit(10)

    client.push_message(params[:user_id], {
      type: "text",
      text: "#{current_user.name}さんから過去に行った店をシェアされました。"
    })

    # 過去に行った店を送信
    message = Command.new.get_record_store_info_temp(current_user.uid)
    client.push_message(params[:user_id], message)

  end

  private

    def restaurant_params
      params.permit(
        :name,
        :address,
        :open_info
      )
    end

    def client
      @client ||= Line::Bot::Client.new { |config|
        config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
        config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
      }
    end

end
