class UsersController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    unless user
      user = User.create(user_params)
    end

    render json: UserSerializer.new(user)
  end

  def show
    render json: UserSerializer.new(User.find(params[:id]))
  end

  def update
    user = User.find(params[:id])
    render json: UserSerializer.new(user.update(address_params))
  end

  private

  def user_params
    params.permit(:email, :name, :google_id)
  end

  def address_params
    params.permit(:street_address_1, :street_address_2, :city, :state, :zip_code)
  end
end