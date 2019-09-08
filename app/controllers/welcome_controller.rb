class WelcomeController < ApplicationController
  def index
    @restaurants = Restaurant.where(user_id: current_user.uid).order('updated_at desc')
  end
  
end
