require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  let(:cart) do
    Cart.create(total: 0)
  end

  let(:product) do
    Product.create(code: 'GR1', name: 'Green Tea', price: 3.11, image_url: 'www.google.pt')
  end

  let(:promotion) do
    Promotion.create(title: 'Green Tea Promotion', product_code: 'GR1', promotion_type: 'buy_x_get_x_free', discount: nil, min_quantity: 1, promotion_free_quantity: 1)
  end

  let(:request_data) do
    {
      cart: {
        total: 3.11,
        cart_items: [
          {
            cart_id: cart.id,
            product_id: product.id,
            quantity: 1,
            undiscounted_price: 6.12,
            discounted_price: 3.11,
            free_quantity: 1,
            promotion_id: promotion.id,
            promotion_status: 'applied'
          }
        ]
      }
    }
  end

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

  describe 'checkout' do
    context 'when all promotion were applied correctly' do
      it 'returns 200 OK status code' do
        post :checkout, params: request_data
        expect(response).to have_http_status(:ok)
      end

      it 'returns a message stating checkout successfully.' do
        post :checkout, params: request_data
        expect(parsed_response['message']).to eq('Checkout completed successfully.')
      end
    end
  end
end
