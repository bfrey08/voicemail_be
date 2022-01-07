class LettersController < ApplicationController
  def create
    
      LobFacade.create_letter({to_address: to_address, from_address: from_address, letter_body: letter_body})
  end
end
