require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  let(:cart) do
    Cart.create(total: 0)
  end

  let(:green_tea) do
    Product.create(code: 'GR1', name: 'Green Tea', price: 3.11, image_url: 'www.google.pt')
  end

  let(:strawberries) do
    Product.create(code: 'SR1', name: 'Strawberries', price: 5.00, image_url: 'www.google.pt')
  end

  let(:coffee) do
    Product.create(code: 'CF1', name: 'Coffee', price: 11.23, image_url: 'www.google.pt')
  end

  let(:green_tea_promotion) do
    Promotion.create(title: 'Green Tea Promotion', product_code: 'GR1', promotion_type: 'buy_x_get_x_free', discount: nil, min_quantity: 1, promotion_free_quantity: 1)
  end

  let(:strawberries_promotion) do
    Promotion.create(title: 'Strawberries Promotion', product_code: 'SR1', promotion_type: 'price_discount_per_quantity', discount: 4.50, min_quantity: 3, promotion_free_quantity: nil)
  end

  let(:coffee_promotion) do
    Promotion.create(title: 'Coffe Promotion', product_code: 'CF1', promotion_type: 'percentage_discount_per_quantity', discount: 2.0/3.0, min_quantity: 3, promotion_free_quantity: nil)
  end

  let(:request_data) do
    {
      cart: {
        cart_id: cart.id,
        total: 30.57,
        cart_items: [
          {
            cart_id: cart.id,
            product_id: green_tea.id,
            quantity: 1,
            undiscounted_price: 6.12,
            discounted_price: 3.11,
            free_quantity: 1,
            promotion_id: green_tea_promotion.id,
            promotions_status: 'applied'
          },
          {
            cart_id: cart.id,
            product_id: strawberries.id,
            quantity: 1,
            undiscounted_price: 5.00,
            discounted_price: nil,
            free_quantity: nil,
            promotion_id: nil,
            promotions_status: 'not_applied'
          },
          {
            cart_id: cart.id,
            product_id: coffee.id,
            quantity: 3,
            undiscounted_price: 33.69,
            discounted_price: 22.46,
            free_quantity: nil,
            promotion_id: coffee_promotion.id,
            promotions_status: 'applied'
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

        parsed_response = JSON.parse(response.body)
        expect(parsed_response['message']).to eq('Checkout completed successfully.')
      end
    end
  end
end
