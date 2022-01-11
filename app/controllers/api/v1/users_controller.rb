class Api::V1::UsersController < ApplicationController


  def create
    user = User.find_by(email: params[:email])

    unless user
      user = User.create!(user_params)
    end

    render json: UserSerializer.new(user)
  end

  def show
    render json: UserSerializer.new(User.find(params[:id]))
  end

  def update
    user = User.find(params[:id])

    if LobFacade.verify_address(address_params) == true
      user.update(address_params)
      render json: UserSerializer.new(user)
    else
      render json: UserSerializer.verification_failed, status: 422
    end
  end

  private

  def user_params
    params.permit(:email, :name, :google_id)
  end

  def address_params
    params.permit(:address_line1, :address_line2, :address_city, :address_state, :address_zip)
  end
end
