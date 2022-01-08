class LetterSerializer
  include JSONAPI::Serializer
  attributes :send_date, 
             :delivery_date, 
             :to_street_address_1,
             :to_street_address_2,
             :to_city,
             :to_state,
             :to_zip,
             :from_street_address_1,
             :from_street_address_2,
             :from_city,
             :from_state,
             :from_zip,
             :body,
             :user_id,
             :to_name,
             :from_name
end