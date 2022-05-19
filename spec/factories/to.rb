FactoryBot.define do
  factory :to, class: "Address" do
    address_line1 { '40 Massachusetts Ave NE' }
    address_city { 'Washington' }
    address_state { 'DC' }
    address_zip { '20002' }
    user
  end
end