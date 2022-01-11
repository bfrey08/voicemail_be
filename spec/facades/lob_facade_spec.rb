require 'rails_helper'

describe LobFacade do
  describe '.verify_address' do
    it 'returns true if an address can be delivered to' do
      address = {
        name: "Burger King",
        address_line1: "2110 S Broadway",
        address_city: "Denver",
        address_state: "CO",
        address_country: "US",
        address_zip: "80210"
      }

      expect(LobFacade.verify_address(address)).to eq(true)
    end

    it 'returns false if an address cant be delivered to' do
      address = {
        name: "alspdgfpcalsd",
        address_line1: "vasadcasdgasdg",
        address_city: "sadmvodmc",
        address_state: "pwefoqckds",
        address_country: "kaosdvkospck",
        address_zip: "43951"
      }

      expect(LobFacade.verify_address(address)).to eq(false)
    end
  end

  describe '.create_letter' do
    context 'when required information entered' do
      it 'sends letter and returns saved letter object' do
        nate = create(:user)
        letter_body = "
                        Senator Michael Bennet,<br><br>
                        Please make GrubHub free.<br><br>
                        Your constituent, <br>
                        Nate
                        "

      to_address = {
                    name: "Burger King",
                    address_line1: "2110 S Broadway",
                    address_city: "Denver",
                    address_state: "CO",
                    address_country: "US",
                    address_zip: "80210"
                   }

      from_address = {
                      name: nate.name,
                      address_line1: nate.address_line1,
                      address_city: nate.address_city,
                      address_state: nate.address_state,
                      address_country: "US",
                      address_zip: nate.address_zip
                     }

        letter = LobFacade.create_letter({to_address: to_address, from_address: from_address, letter_body: letter_body, user_id: nate.id})


        expect(letter).to be_a(Letter)
        expect(letter.send_date).not_to be nil
        expect(letter.delivery_date).not_to be nil
        expect(letter.body).to eq("
                        Senator Michael Bennet,<br><br>
                        Please make GrubHub free.<br><br>
                        Your constituent, <br>
                        Nate
                        ")
      end
    end
    context 'when letter body is not entered (sad path)' do
      it 'returns not-saved letter object with errors' do
        nate = create(:user)
      to_address = {
                    name: "Burger King",
                    address_line1: "2110 S Broadway",
                    address_city: "Denver",
                    address_state: "CO",
                    address_country: "US",
                    address_zip: "80210"
                   }

      from_address = {
                      name: nate.name,
                      address_line1: nate.address_line1,
                      address_city: nate.address_city,
                      address_state: nate.address_state,
                      address_country: "US",
                      address_zip: nate.address_zip
                     }

        letter = LobFacade.create_letter({to_address: to_address, from_address: from_address, user: nate})

        expect(letter.id).to be nil
        expect(letter.errors.messages[:body]).to eq(["can't be blank"])
      end
    end
  end
end
