require 'rails_helper'

RSpec.describe PromotionsController, type: :controller do
  describe 'GET /index' do
    context 'when there is promotions created' do
      before do
        Promotion.create(title: 'Green Tea Promotion', product_code: 'GR1', promotion_type: 'buy_x_get_x_free', discount: nil, min_quantity: 1, promotion_free_quantity: 1)
        Promotion.create(title: 'Strawberries Promotion', product_code: 'SR1', promotion_type: 'price_discount_per_quantity', discount: 4.50, min_quantity: 3, promotion_free_quantity: nil)
        Promotion.create(title: 'Coffee Promotion', product_code: 'CF1', promotion_type: 'percentage_discount_per_quantity', discount: (2.0/3.0), min_quantity: 3, promotion_free_quantity: nil)
      end

      it 'return a 200 OK Status Code' do
        get :index
        expect(response).to have_http_status(:ok)
      end

      it 'returns list of promotions as JSON' do
        get :index
        parsed_response = JSON.parse(response.body)

        expect(parsed_response).to be_an(Array)
        expect(parsed_response.length).to eq(3)
      end
    end

    context 'when there is no promotions created' do
      before do
        Promotion.destroy_all
      end

      it 'return a 404 not_found Status Code' do
        get :index
        expect(response).to have_http_status(:not_found)
      end

      it 'returns an error message as JSON' do
        get :index
        parsed_response = JSON.parse(response.body)

        expect(parsed_response['error']).to eq('No promotions found.')
      end
    end
  end
end
