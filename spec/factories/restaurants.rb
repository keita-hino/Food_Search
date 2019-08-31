FactoryBot.define do
  factory :restaurant do
    user_id { "USER_ID" }
    name { "MyString" }
    address { "MyString" }
    open_info { "MyString" }
    latitude { "9.99" }
    longitude { "9.99" }
    image_url { "MyText" }
    site_url { "MyText" }
  end
end
