class CartsController < ApplicationController
  def create
    @cart = Cart.new(total: 0)

    if @cart.save
      render json: @cart, status: :ok
    else
      render json: { error: 'Your cart cannot be created. Try again later.' }, status: :unprocessable_entity
    end
  end
end
