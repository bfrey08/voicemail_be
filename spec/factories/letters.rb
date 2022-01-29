FactoryBot.define do
  factory :letter do
    to_name { Faker::Name.name }
    from_name { Faker::Name.name }
    body { Faker::Lorem.paragraph }
    to_address_line1 { '40 Massachusetts Ave NE' }
    to_address_city { 'Washington' }
    to_address_state { 'DC' }
    to_address_zip { '20002' }
    from_address_line1 { '11913 Freedom Dr' }
    from_address_line2 { '#35' }
    from_address_city { 'Reston' }
    from_address_state { 'VA' }
    from_address_zip { '20190' }
    user
  end
end
