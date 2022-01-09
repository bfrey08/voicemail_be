class UserSerializer
  include JSONAPI::Serializer

  attributes :email, :name, :google_id, :address_line1, :address_line2, :address_city, :address_state, :address_zip
end