require 'rails_helper'

RSpec.describe Cart, type: :model do
  context 'validate cart.total' do
    describe 'when total is nil' do
      let(:cart) { FactoryBot.build(:cart, total: nil) }

      it 'valid' do
        expect(cart).to be_valid
      end
    end

    describe 'when using self.total as a reader' do
      let(:cart) { FactoryBot.build(:cart, total: 10.00) }

      it 'returns the correct value' do
        expect(cart.total).to eq(10.00)
      end
    end

    describe 'when using self.total as a writer' do
      let(:cart) { FactoryBot.build(:cart, total: 10.00) }

      it 'sets the correct value' do
        cart.total = 20.00

        expect(cart.total).to eq(20.00)
      end
    end
  end

  context '#validate_cart_total' do
    let(:product) { FactoryBot.build(:product, code: 'GR1', name: 'Green Tea', price: 3.11) }
    let(:cart) { FactoryBot.build(:cart, total: 3.11) }
    let(:cart_item) { FactoryBot.build(:cart_item, cart_id: cart.id, product_id: product.id, quantity: 1, free_quantity: 1, undiscounted_price: 6.12, discounted_price: 3.11) }

    describe 'when total is correct' do
      it 'returns true' do
        expect(cart.validate_total_price).to eq(true)
      end
    end

    describe 'when total is incorrect' do
      it 'returns false' do
        cart.total = 5.00

        expect(cart.validate_total_price).to eq(false)
      end
    end
  end
end
