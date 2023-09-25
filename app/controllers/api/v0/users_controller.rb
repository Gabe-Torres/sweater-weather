class Api::V0::UsersController < ApplicationController
  def create
    require 'pry'; binding.pry
    user = User.create!(user_params)
    if user.save
      render json: UsersSerializer.new(user), status: :created
    else
      render json: Error.new(error: user.errors.full_messages.to_sentence, status: 400), status: :bad_request
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end