class RepresentativeSerializer
  include JSONAPI::Serializer
  attributes :address_city,
             :address_line1,
             :address_state,
             :address_zip,
             :name,
             :title
end