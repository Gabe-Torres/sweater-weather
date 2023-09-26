class Api::V1::MunchiesController < ApplicationController
  def index
    # binding.pry
    munchies = MunchiesFacade.get_food(params[:destination], params[:food])
  end
end