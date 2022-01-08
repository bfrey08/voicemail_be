class UserSerializer
  include JSONAPI::Serializer

  attributes :email, :name, :google_id, :street_address_1, :street_address_2, :city, :state, :zip_code
end