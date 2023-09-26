class PromotionsController < ApplicationController

  def index
    @promotions = Promotion.all

    if @promotions.empty?
      render json: { error: 'No promotions found.' }, status: :not_found
    else
      render json: @promotions
    end
  end
end
