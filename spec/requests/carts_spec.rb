require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  describe 'POST /create' do
    context 'when cart creation is successful' do
      it 'creates a new cart' do
        post :create
        created_cart = Cart.last

        expect(response).to have_http_status(:ok)
        expect(created_cart).to be_present
      end
    end
  end
end
