class Api::V1::LettersController < ApplicationController
  def create
    letter = LobFacade.create_letter(
                                    {
                                      to_address: to_address,
                                      from_address: from_address,
                                      letter_body: params[:body], 
                                      user_id: params[:user_id]
                                    }
                                  )

    render json: LetterSerializer.new(letter)
  end

private

    def to_address
      {
                    name: params[:to_name],
                    address_line1: params[:to_street_address_1],
                    address_line2: params[:to_street_address_2],
                    address_city: params[:to_city],
                    address_state: params[:to_state],
                    address_country: "US",
                    address_zip: params[:to_zip]
      }
    end

    def from_address
      {
                    name: params[:from_name],
                    address_line1: params[:from_street_address_1],
                    address_line2: params[:from_street_address_2],
                    address_city: params[:from_city],
                    address_state: params[:from_state],
                    address_country: "US",
                    address_zip: params[:from_zip]
      }
    end
end
