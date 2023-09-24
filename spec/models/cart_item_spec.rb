require 'rails_helper'

RSpec.describe CartItem, type: :model do
  let(:cart) { FactoryBot.create(:cart) }
  let(:product) { FactoryBot.create(:product) }

  context 'validates cart_id' do
    describe 'when cart_id is nil' do
      let(:product) { FactoryBot.build(:product) }
      let(:cart_item) { FactoryBot.build(:cart_item, cart_id: nil, product_id: product.id) }

      it 'not valid' do
        expect(cart_item).not_to be_valid
      end
    end

    describe 'when cart_id is not nil' do
      let(:cart_item) { FactoryBot.build(:cart_item, cart_id: cart.id, product_id: product.id) }

      it 'valid' do
        expect(cart_item).to be_valid
      end

      it 'sets the correct cart_id' do
        expect(cart_item.cart_id).to eq(cart.id)
      end
    end
  end

  context 'validates product_id' do
    describe 'when product_id is nil' do
      let(:cart_item) { FactoryBot.build(:cart_item, cart_id: cart.id, product_id: nil) }

      it 'not valid' do
        expect(cart_item).not_to be_valid
      end
    end

    describe 'when product_id is not nil' do
      let(:cart_item) { FactoryBot.build(:cart_item, cart_id: cart.id, product_id: product.id) }

      it 'valid' do
        expect(cart_item).to be_valid
      end

      it 'sets the correct cart_id' do
        expect(cart_item.product_id).to eq(product.id)
      end
    end
  end

  context '#self.quantity' do
    let(:cart_item) { FactoryBot.build(:cart_item, cart_id: cart.id, product_id: product.id, quantity: 1) }

    describe 'when using it as a reader' do
      it 'returns the correct quantity' do
        expect(cart_item.quantity).to eq(1)
      end
    end

    describe 'when using it as a writer' do
      it 'updates the item with the correct quantity' do
        cart_item.quantity = 2

        expect(cart_item.quantity).to eq(2)
      end
    end
  end

  context '#self.undiscounted_price' do
    let(:cart_item) { FactoryBot.build(:cart_item, cart_id: cart.id, product_id: product.id, undiscounted_price: 5.00) }

    describe 'when using it as a reader' do
      it 'returns the correct price' do
        expect(cart_item.undiscounted_price).to eq(5.00)
      end
    end

    describe 'when using it as a writer' do
      it 'updates the item with the correct undiscounted_price' do
        cart_item.undiscounted_price = 10.00

        expect(cart_item.undiscounted_price).to eq(10.00)
      end
    end
  end

  context '#self.discounted_price' do
    let(:cart_item) { FactoryBot.build(:cart_item, cart_id: cart.id, product_id: product.id, discounted_price: 10.00) }

    describe 'when using it as a reader' do
      it 'returns the correct price' do
        expect(cart_item.discounted_price).to eq(10.00)
      end
    end

    describe 'when using it as a writer' do
      it 'updates the item with the correct discounted_price' do
        cart_item.discounted_price = 9.99

        expect(cart_item.discounted_price).to eq(9.99)
      end
    end
  end
end
