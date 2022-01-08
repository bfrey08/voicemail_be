FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    google_id { Faker::Alphanumeric.alphanumeric(number: 15) }
    street_address_1 { Faker::Address.street_address }
    street_address_2 { Faker::Address.secondary_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip_code { Faker::Address.zip_code }
  end
end