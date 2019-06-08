FactoryBot.define do
  factory :restaurant do
    user_id { "" }
    name { "MyString" }
    address { "MyString" }
    open_info { "MyString" }
    latitude { "9.99" }
    longitude { "9.99" }
    url { "MyText" }
    deleted_at { "2019-06-08 11:11:21" }
  end
end
