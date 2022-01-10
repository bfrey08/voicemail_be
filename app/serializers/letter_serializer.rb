class LetterSerializer
  include JSONAPI::Serializer
  attributes :send_date, 
             :delivery_date, 
             :to_address_line1,
             :to_address_line2,
             :to_address_city,
             :to_address_state,
             :to_address_zip,
             :from_address_line1,
             :from_address_line2,
             :from_address_city,
             :from_address_state,
             :from_address_zip,
             :body,
             :user_id,
             :to_name,
             :from_name

   def self.errors(errors)
     {
       "message": "Your letter could not be sent.",
       "errors": errors
     }
   end

   def self.letters_not_found
      {
       "message": "Letters not found",
       "errors": ["No letters with that user id could be found. Check that you entered it correctly"]
     }
   end
end