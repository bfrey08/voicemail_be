FactoryBot.define do
  factory :letter do
    to_name { Faker::Name.name }
    from_name { Faker::Name.name }
    body { Faker::Lorem.paragraph }
    to
    from
    user
  end
end
