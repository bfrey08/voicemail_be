class ToSerializer
  include JSONAPI::Serializer
  attributes :address_line1,
             :address_line2,
             :address_city,
             :address_state,
             :address_zip
end