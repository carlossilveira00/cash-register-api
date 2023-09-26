class ProductsController < ApplicationController
  def index
    @products = Product.all

    if @products.empty?
      render json: { error: 'No products found.' }, status: :not_found
    else
      render json: @products
    end
  end

end
