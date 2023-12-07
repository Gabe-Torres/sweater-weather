class Api::V0::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      # require 'pry'; binding.pry
      render json: UsersSerializer.new(user), status: :ok
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end
end