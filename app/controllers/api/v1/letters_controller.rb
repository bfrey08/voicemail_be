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

    if letter.id == nil
      render json: LetterSerializer.errors(letter.errors.full_messages), status: 422
    else
      render json: LetterSerializer.new(letter)
    end
  end

private

    def to_address
      {
                    name: params[:to_name],
                    address_line1: params[:to_address_line1],
                    address_line2: params[:to_address_line2],
                    address_city: params[:to_address_city],
                    address_state: params[:to_address_state],
                    address_country: "US",
                    address_zip: params[:to_address_zip]
      }
    end

    def from_address
      {
                    name: params[:from_name],
                    address_line1: params[:from_address_line1],
                    address_line2: params[:from_address_line2],
                    address_city: params[:from_address_city],
                    address_state: params[:from_address_state],
                    address_country: "US",
                    address_zip: params[:from_address_zip]
      }
    end
end
