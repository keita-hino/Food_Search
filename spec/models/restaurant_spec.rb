require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  describe 'scope' do
    it 'user_id検索で該当のUserのみ取得できること' do
      FactoryBot.create(:restaurant)
      FactoryBot.create(:restaurant,user_id: "not_match")
      expect(Restaurant.user_uid_is("USER_ID").count).to eq(1)
      expect(Restaurant.user_uid_is("USER_ID").first.user_id).to eq("USER_ID")
    end
  end
end
