FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    google_id { Faker::Alphanumeric.alphanumeric(number: 15) }
    address_line1 { Faker::Address.street_address }
    address_line2 { Faker::Address.secondary_address }
    address_city { Faker::Address.city }
    address_state { Faker::Address.state_abbr }
    address_zip { Faker::Address.zip_code }
  end
end