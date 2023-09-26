require 'rails_helper'

RSpec.describe 'Products', type: :request do
  describe 'GET /index' do
    context 'when there is products created' do
      let(:product1) { FactoryBot.create(:product, code: 'GR1', name: 'Green Tea', price: 3.11, image_url: 'www.google.pt') }
      let(:product2) { FactoryBot.create(:product, code: 'SR1', name: 'Strawberries', price: 5.00, image_url: 'www.google.pt') }
      let(:product3) { FactoryBot.create(:product, code: 'CF1', name: 'Coffee', price: 11.23, image_url: 'www.google.pt') }

      it 'return a 200 OK Status Code' do
        get :index
        expect(response).to have_http_status(:ok)
      end

      it 'returns list of products as JSON' do
        get :index
        parsed_response = JSON.parse(response.body)

        expect(parsed_response).to be_an(Array)
        expect(parsed_response.length).to eq(3)
      end
    end

    context 'when there is no products created' do
      it 'return a 404 not_found Status Code' do
        get :index
        expect(response).to have_http_status(:not_found)
      end

      it 'returns an error message as JSON' do
        get :index
        parsed_response = JSON.parse(response.body)

        expect(parsed_response['error']).to eq('No products found.')
      end
    end
  end
end
