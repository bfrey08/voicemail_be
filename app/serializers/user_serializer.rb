class UserSerializer
  include JSONAPI::Serializer

  attributes :email,
             :name,
             :google_id,
             :address_line1,
             :address_line2,
             :address_city,
             :address_state,
             :address_zip

  def self.verification_failed
    {
      "message": 'Address failed to pass verification; please try again.'
    }
  end
end
