require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "requrest" do
    it "res code 200" do
      get '/index' => 'linebot#index'
      expect(response.status).to eq 200
    end
  end
end
