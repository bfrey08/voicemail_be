class UserSerializer
  include JSONAPI::Serializer

  attributes :email,
             :name,
             :google_id

  attribute :address do |user|
    user.address
  end

  def self.verification_failed
    {
      "message": 'Address failed to pass verification; please try again.'
    }
  end
end
