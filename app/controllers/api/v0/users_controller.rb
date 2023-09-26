class Api::V0::UsersController < ApplicationController
  def create
    require 'pry'; binding.pry
    render json: UsersSerializer.new(User.create!(user_params)), status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :bad_request
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end