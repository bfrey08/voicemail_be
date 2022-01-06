class LettersController < ApplicationController
  def self.create
    lob = LobService.client
    to_address = lob.addresses.create(
                                      name: "Burger King",
                                      address_line1: "2110 S Broadway",
                                      address_city: "Denver",
                                      address_state: "CO",
                                      address_country: "US",
                                      address_zip: 80210
                                    )
    from_address = lob.addresses.create(
                                        name: "Wendy's",
                                        address_line1: "515 S Broadway",
                                        address_city: "Denver",
                                        address_state: "CO",
                                        address_country: "US",
                                        address_zip: 80209
                                      )
      LobFacade.create_letter(to_address, from_address)
  end
end
