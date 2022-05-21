FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    google_id { Faker::Alphanumeric.alphanumeric(number: 15) }
    after :create do |user|
      create :address, user: user
    end
  end
end
