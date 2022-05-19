FactoryBot.define do
  factory :from, class: "Address" do
    address_line1 { '11913 Freedom Dr' }
    address_line2 { '#35' }
    address_city { 'Reston' }
    address_state { 'VA' }
    address_zip { '20190' }
    user
  end
end