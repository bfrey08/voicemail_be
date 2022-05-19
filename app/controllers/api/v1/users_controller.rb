class Api::V1::UsersController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user == nil && params[:password] == params[:password_confirmation]
      user = User.create!(user_params)
      render json: UserSerializer.new(user)
    elsif user && params[:google_id] == nil
      render json: { error: 'Email has already been registered'}, status: 422
    elsif params[:password] != params[:password_confirmation]
      render json: { error: 'Password and confirmation do not match'}, status: 422
    else
      render json: UserSerializer.new(user)
    end
  end

  def show
    render json: UserSerializer.new(User.find(params[:id]))
  end

  def update
    user = User.find(params[:id])

    if LobFacade.verify_address(address_params)
      address_params_with_name = address_params.merge({name: user.name})
      address = Address.create!(address_params_with_name)
      user.add_address(address)

      render json: UserSerializer.new(user)
    else
      render json: UserSerializer.verification_failed, status: 422
    end
  end

  private

  def user_params
    params.permit(:email, :name, :password, :password_confirmation, :google_id)
  end

  def address_params
    params.permit(:name, :address_line1, :address_line2, :address_city, :address_state, :address_zip)
  end
end
