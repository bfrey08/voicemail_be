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
end