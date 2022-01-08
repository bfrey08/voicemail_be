require 'rails_helper'

describe LobFacade do
  describe '.create_letter' do
    context 'when required information entered' do
      it 'sends letter and returns saved letter object' do
        nate = User.create!(
                    full_name: "Nate Brown",
                    street_address_1: "515 S Broadway",
                    city: "Denver",
                    state: "CO",
                    zip_code: 80209
                  )
        letter_body = "
                        Senator Michael Bennet,
                        Please make GrubHub free.
                        Your constituent,
                        Nate
                        "

      to_address = {
                    name: "Burger King",
                    address_line1: "2110 S Broadway",
                    address_city: "Denver",
                    address_state: "CO",
                    address_country: "US",
                    address_zip: 80210
                   }

      from_address = {
                      name: nate.full_name,
                      address_line1: nate.street_address_1,
                      address_city: nate.city,
                      address_state: nate.state,
                      address_country: "US",
                      address_zip: nate.zip_code
                     }

        letter = LobFacade.create_letter({to_address: to_address, from_address: from_address, letter_body: letter_body, user_id: nate.id})


        expect(letter).to be_a(Letter)
        expect(letter.send_date).not_to be nil
        expect(letter.delivery_date).not_to be nil
        expect(letter.body).to eq("
                        Senator Michael Bennet,
                        Please make GrubHub free.
                        Your constituent,
                        Nate
                        ")
      end
    end
    context 'when letter body is not entered (sad path)' do
      it 'returns not-saved letter object with errors' do
        nate = User.create!(
                    full_name: "Nate Brown",
                    street_address_1: "515 S Broadway",
                    city: "Denver",
                    state: "CO",
                    zip_code: 80209
                  )

      to_address = {
                    name: "Burger King",
                    address_line1: "2110 S Broadway",
                    address_city: "Denver",
                    address_state: "CO",
                    address_country: "US",
                    address_zip: 80210
                   }

      from_address = {
                      name: nate.full_name,
                      address_line1: nate.street_address_1,
                      address_city: nate.city,
                      address_state: nate.state,
                      address_country: "US",
                      address_zip: nate.zip_code
                     }

        letter = LobFacade.create_letter({to_address: to_address, from_address: from_address, user: nate})

        expect(letter.id).to be nil
        expect(letter.errors.messages[:body]).to eq(["can't be blank"])
      end
    end
  end
end
