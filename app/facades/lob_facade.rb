class LobFacade
  extend AddressFormattable
  def self.verify_address(address)
    lob = LobService.verification_client

    verification = lob.us_verifications.verify(verification_details(address: address))

    verification['deliverability'] == 'deliverable'
  end

  def self.create_letter(letter_data)
    user = User.find(letter_data[:user_id])

    Letter.create(letter_details(user: user, letter_data: letter_data))
  end

  def self.send_letter(user_email)
    lob = LobService.client
    user = User.find_by(email: user_email)

    letter = user.letters.order(:created_at).last
    to_address = Address.find(letter.to_id)

    letter_data = {
                    to_address: to_address.address_hash,
                    from_address: user.address_hash,
                    letter_body: letter.body,
                    user_id: user.id
                  }
  
    to_address, from_address = create_lob_addresses(lob: lob, letter_data: letter_data)

    confirmation = lob.letters.create(lob_details(
                                                    to_address: to_address,
                                                    from_address: from_address,
                                                    letter_data: letter_data
                                                    )
                                     )
    letter.update(
      send_date: confirmation['send_date'][0..9],
      delivery_date: confirmation['expected_delivery_date'],
      preview_url: confirmation['url']
    )
    letter
  end

  def self.preview(letter_data)
    lob = LobService.test_client
    user = User.find(letter_data[:user_id])

    letter = Letter.new(letter_details(user: user, letter_data: letter_data))

    if letter.save
      to_address, from_address = create_lob_addresses(lob: lob, letter_data: letter_data.except(:user_id))

      confirmation = lob.letters.create(lob_details(
                                                    to_address: to_address,
                                                    from_address: from_address,
                                                    letter_data: letter_data
                                                    ))
      letter.update(
        send_date: confirmation['send_date'][0..9],
        delivery_date: confirmation['expected_delivery_date'],
        preview_url: confirmation['url']
      )
    end
    letter
  end

  private
    def self.to_address(letter_data)
      Address.create!(letter_data[:to_address].except(:address_country))
    end

    def self.create_lob_addresses(lob:, letter_data:)
      to_address = lob.addresses.create(letter_data[:to_address])
      from_address = lob.addresses.create(letter_data[:from_address])
      [to_address, from_address]
    end
end
