class Api::V1::RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.user_uid_is(current_user.uid)
                            .order('updated_at desc')

    @users = Request.new(
            client: client,
            users: Lineuser.all
          ).user_list

  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy!
    render json: '', status: :ok
  end

  def share
    restaurants = Restaurant.where(id: share_restaurant_params[:restaurant_id])
    user_id = User.find(share_restaurant_params[:user][:id])&.uid

    client.push_message(user_id, {
      type: "text",
      text: "#{current_user.name}さんから過去に行った店をシェアされました。"
    })

    # 過去に行った店を送信
    message = Command.new.get_record_store_info_temp(current_user.uid, restaurants)
    client.push_message(user_id, message)
  end

  private

    def restaurant_params
      params.permit(
        :name,
        :address,
        :open_info
      )
    end

    def share_restaurant_params
      params.permit(
        :restaurant_id,
        user: {}
      )
    end

    def client
      @client ||= Line::Bot::Client.new { |config|
        config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
        config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
      }
    end
end
