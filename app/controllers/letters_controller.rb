class LettersController < ApplicationController
  def self.create
    letter_body = "
    Senator Michael Bennet,
    Please make GrubHub free.
    Your constituent,
    Nate"

    to_address = {
                  name: "Burger King",
                  address_line1: "2110 S Broadway",
                  address_city: "Denver",
                  address_state: "CO",
                  address_country: "US",
                  address_zip: 80210
                  }

    from_address = {
                name: "Wendy's",
                address_line1: "515 S Broadway",
                address_city: "Denver",
                address_state: "CO",
                address_country: "US",
                address_zip: 80209
    }
    
    letter = LobFacade.create_letter({to_address: to_address, from_address: from_address, letter_body: letter_body})

    require 'pry'; binding.pry
  end
end
