FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    google_id { Faker::Alphanumeric.alphanumeric(number: 15) }
    address_line1 { '11913 Freedom Dr' }
    address_line2 { '#35' }
    address_city { 'Reston' }
    address_state { 'VA' }
    address_zip { '20190' }
  end
end
