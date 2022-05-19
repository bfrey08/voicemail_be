class AddressSerializer
  include JSONAPI::Serializer
  attributes :user_id,
             :address_line1,
             :address_line2,
             :address_city,
             :address_state,
             :address_zip

  def self.address_destroyed
    { message: "Address deleted successfully" }
  end
end