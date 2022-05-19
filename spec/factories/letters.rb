FactoryBot.define do
  factory :letter do
    body { Faker::Lorem.paragraph }
    to
    from
    user
  end
end
