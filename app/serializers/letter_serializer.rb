class LetterSerializer
  include JSONAPI::Serializer
  attributes :send_date,
             :delivery_date,
             :body,
             :user_id,
             :to_name,
             :from_name,
             :preview_url
             
  belongs_to :to
  belongs_to :from

  def self.errors(errors)
    {
      "message": 'Your letter could not be sent.',
      "errors": errors
    }
  end

  def self.letters_not_found
    {
      "message": 'Letters not found',
      "errors": ['No letters with that user id could be found. Check that you entered it correctly']
    }
  end
end
