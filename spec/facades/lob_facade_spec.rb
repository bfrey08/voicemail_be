require 'rails_helper'

describe LobFacade do
  describe '.verify_address' do
    it 'returns true if an address can be delivered to', :vcr do
      address = {
        name: 'Burger King',
        address_line1: '2110 S Broadway',
        address_city: 'Denver',
        address_state: 'CO',
        address_country: 'US',
        address_zip: '80210'
      }

      expect(LobFacade.verify_address(address)).to eq(true)
    end

    it 'returns false if an address cant be delivered to', :vcr do
      address = {
        name: 'alspdgfpcalsd',
        address_line1: 'vasadcasdgasdg',
        address_city: 'sadmvodmc',
        address_state: 'pwefoqckds',
        address_country: 'kaosdvkospck',
        address_zip: '43951'
      }

      expect(LobFacade.verify_address(address)).to eq(false)
    end
  end

  describe '.create_letter' do
    context 'when required information entered' do
      it 'sends letter and returns saved letter object', :vcr do
        nate = create(:user)
        letter_body = "
                        Senator Michael Bennet,<br><br>
                        Please make GrubHub free.<br><br>
                        Your constituent, <br>
                        Nate
                        "

        to_address = {
          name: 'Burger King',
          address_line1: '2110 S Broadway',
          address_city: 'Denver',
          address_state: 'CO',
          address_country: 'US',
          address_zip: '80210'
        }

        from_address = nate.address_hash

        letter = LobFacade.create_letter({ 
                                           to_address: to_address,
                                           from_address: from_address,
                                           letter_body: letter_body,
                                           user_id: nate.id 
                                         })

        expect(letter).to be_a(Letter)
        expect(letter.send_date).to be nil
        expect(letter.delivery_date).to be nil
        expect(letter.body).to eq("
                        Senator Michael Bennet,<br><br>
                        Please make GrubHub free.<br><br>
                        Your constituent, <br>
                        Nate
                        ")
      end
    end
    context 'when letter body is not entered (sad path)' do
      it 'returns not-saved letter object with errors', :vcr do
        nate = create(:user)
        to_address = {
          name: 'Burger King',
          address_line1: '2110 S Broadway',
          address_city: 'Denver',
          address_state: 'CO',
          address_country: 'US',
          address_zip: '80210'
        }

        from_address = {
          name: nate.name,
          address_country: 'US'
        }.merge(nate.address_hash)

        letter = LobFacade.create_letter({ 
                                            to_address: to_address,
                                            from_address: from_address,
                                            user_id: nate.id
                                         })

        expect(letter.id).to be nil
        expect(letter.errors.messages[:body]).to eq(["can't be blank"])
      end
    end
  end

  describe '.send' do
    context 'when given a valid letter id' do
      it 'sends a users most recent letter', :vcr do
        nate = create(:user)
        letter_body = "
                        Senator Michael Bennet,<br><br>
                        Please make GrubHub free.<br><br>
                        Your constituent, <br>
                        Nate
                        "

        to_address = {
          name: 'Burger King',
          address_line1: '2110 S Broadway',
          address_city: 'Denver',
          address_state: 'CO',
          address_country: 'US',
          address_zip: '80210'
        }

        from_address = nate.address_hash

        saved_letter_1 = LobFacade.create_letter({ to_address: to_address, from_address: from_address, letter_body: "Hey hey hey",
                                           user_id: nate.id })

        saved_letter_2 = LobFacade.create_letter({ to_address: to_address, from_address: from_address, letter_body: letter_body,
                                           user_id: nate.id })

        sent_letter = LobFacade.send_letter(nate.email)

        expect(saved_letter_2.send_date).to be nil
        expect(saved_letter_2.delivery_date).to be nil

        expect(sent_letter.send_date).not_to be nil
        expect(sent_letter.delivery_date).not_to be nil
        expect(saved_letter_2.id).to eq(sent_letter.id)
      end
    end
  end

  describe '.preview' do
    context 'when given valid letter data' do
      it 'returns a letter object with a PDF preview URL', :vcr do
        nate = create(:user)
        letter_body = "
                        Senator Michael Bennet,<br><br>
                        Please make GrubHub free.<br><br>
                        Your constituent, <br>
                        Nate
                        "

        to_address = {
          name: 'Burger King',
          address_line1: '2110 S Broadway',
          address_city: 'Denver',
          address_state: 'CO',
          address_country: 'US',
          address_zip: '80210'
        }

        from_address = nate.address_hash

        preview_letter = LobFacade.preview({ to_address: to_address, from_address: from_address, letter_body: letter_body,
                                           user_id: nate.id })

        expect(preview_letter.id).to be_an Integer
        expect(preview_letter.to.name).to be_a String
        expect(preview_letter.from.name).to be_a String
        expect(preview_letter.preview_url).to include("https://lob-assets.com/letters/")
      end
    end
  end
end
