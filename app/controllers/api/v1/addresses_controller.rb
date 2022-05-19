class Api::V1::AddressesController < ApplicationController
  def create
    user = User.find(params[:user_id])
    params[:name] = user.name

    address = Address.create!(address_params)

    render json: AddressSerializer.new(address)
  end

  def update
    address = Address.find(params[:id])
    address.update(address_params)

    render json: AddressSerializer.new(address)
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy!

    render json: AddressSerializer.address_destroyed
  end


private

    def address_params
      params.permit(
                    :name,
                    :user_id,
                    :address_line1,
                    :address_line2,
                    :address_city,
                    :address_state,
                    :address_zip
                   )
    end
end
