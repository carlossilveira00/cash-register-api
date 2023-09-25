require 'rails_helper'

RSpec.describe Promotion, type: :model do
  context 'validates promotion.title' do

    describe 'when promotion.title is nil' do
      let(:promotion) { FactoryBot.build(:promotion, title: nil) }

      it 'not valid' do
        expect(promotion).not_to be_valid
      end
    end

    describe 'when promotion.title is not a string' do
      let(:promotion) { FactoryBot.build(:promotion, title: 5.99) }

      it 'not valid' do
        expect(promotion).not_to be_valid
      end
    end

    describe 'when promotion.title is blank' do
      let(:promotion) { FactoryBot.build(:promotion, title: '') }

      it 'not valid' do
        expect(promotion).not_to be_valid
      end
    end

    describe 'when promotion.title is a string' do
      let(:promotion) { FactoryBot.build(:promotion) }

      it 'valid' do
        expect(promotion).to be_valid
      end

      it 'sets the correct promotion.title' do
        expect(promotion.title).to eq('Green Tea Promotion')
      end
    end
  end

  context 'validates promotion.product_code' do
    describe 'when promotion.product_code is nil' do
      let(:promotion) { FactoryBot.build(:promotion, product_code: nil) }

      it 'not valid' do
        expect(promotion).not_to be_valid
      end
    end

    describe 'when promotion.product_code is not a string' do
      let(:promotion) { FactoryBot.build(:promotion, product_code: 5.99) }

      it 'not valid' do
        expect(promotion).not_to be_valid
      end
    end

    describe 'when promotion.product_code is blank' do
      let(:promotion) { FactoryBot.build(:promotion, product_code: '') }

      it 'not valid' do
        expect(promotion).not_to be_valid
      end
    end

    describe 'when promotion.product_code is a string' do
      let(:promotion) { FactoryBot.build(:promotion) }

      it 'valid' do
        expect(promotion).to be_valid
      end

      it 'sets the correct promotion.product_code' do
        expect(promotion.product_code).to eq('GR1')
      end
    end
  end

  context 'validates promotion.promotion_type' do
    describe 'when promotion.promotion_type is nil' do
      let(:promotion) { FactoryBot.build(:promotion, promotion_type: nil) }

      it 'not valid' do
        expect(promotion).not_to be_valid
      end
    end

    describe 'when promotion.promotion_type is blank' do
      let(:promotion) { FactoryBot.build(:promotion, promotion_type: '') }

      it 'not valid' do
        expect(promotion).not_to be_valid
      end
    end

    describe 'when promotion.promotion_type is a different type from the allowed types' do
      let(:promotion) { FactoryBot.build(:promotion, promotion_type: 'random_promotion') }

      it 'not valid' do
        expect(promotion).not_to be_valid
      end
    end

    describe 'when promotion.promotion_type is one of the allowed types' do
      let(:promotion) { FactoryBot.build(:promotion) }

      it 'valid' do
        expect(promotion).to be_valid
      end

      it 'sets the correct promotion.type' do
        expect(promotion.promotion_type).to eq('buy_x_get_x_free')
      end
    end
  end

  context 'promotion type: buy_x_get_x_free' do
    describe 'when it has a discount' do
      let(:promotion) { FactoryBot.build(:promotion, discount: 50.00) }

      it 'not valid' do
        expect(promotion).not_to be_valid
      end

      it 'raises error stating discount should not be present' do
        promotion.valid?
        expect(promotion.errors[:base]).to include('This type of promotion does not have discount.')
      end
    end

    describe 'when min_quantity is not present' do
      let(:promotion) { FactoryBot.build(:promotion, min_quantity: nil) }

      it 'not valid' do
        expect(promotion).not_to be_valid
      end

      it 'raises error stating it should be present' do
        promotion.valid?
        expect(promotion.errors[:base]).to include('This type of promotion must have a minimum quantity and a promotion free quantity.')
      end
    end

    describe 'when promotion_free_quantity is not present' do
      let(:promotion) { FactoryBot.build(:promotion, promotion_free_quantity: nil) }

      it 'not valid' do
        expect(promotion).not_to be_valid
      end

      it 'raises error stating it should be present' do
        promotion.valid?
        expect(promotion.errors[:base]).to include('This type of promotion must have a minimum quantity and a promotion free quantity.')
      end
    end

    describe 'when promotion_free_quantity, min_quantity are present and discount is nil' do
      let(:promotion) { FactoryBot.build(:promotion, min_quantity: 1, promotion_free_quantity: 1, discount: nil) }

      it 'valid' do
        expect(promotion).to be_valid
      end

      it 'sets the attribute correctly' do
        expect(promotion.min_quantity).to eq(1)
        expect(promotion.promotion_free_quantity).to eq(1)
        expect(promotion.discount).to eq(nil)
      end
    end
  end

  context 'promotion type: price_discount_per_quantity' do
    describe 'when it has promotion_free_quantity' do
      let(:promotion) { FactoryBot.build(:promotion, promotion_type: 'price_discount_per_quantity',  min_quantity: 3, discount: 4.50, promotion_free_quantity: 2) }

      it 'not valid' do
        expect(promotion).not_to be_valid
      end

      it 'raises error stating promotion_free_quantity should not be present' do
        promotion.valid?
        expect(promotion.errors[:base]).to include('This type of promotion does not have promotion free quantity.')
      end
    end

    describe 'when min_quantity is not present' do
      let(:promotion) { FactoryBot.build(:promotion, promotion_type: 'price_discount_per_quantity',  min_quantity: nil, discount: 4.50, promotion_free_quantity: nil) }

      it 'not valid' do
        expect(promotion).not_to be_valid
      end

      it 'raises error stating it should be present' do
        promotion.valid?
        expect(promotion.errors[:base]).to include('This type of promotion must have a minimum quantity and a discount.')
      end
    end

    describe 'when discount is not present' do
      let(:promotion) { FactoryBot.build(:promotion, promotion_type: 'price_discount_per_quantity',  min_quantity: 3, discount: nil, promotion_free_quantity: nil) }

      it 'not valid' do
        expect(promotion).not_to be_valid
      end

      it 'raises error stating it should be present' do
        promotion.valid?
        expect(promotion.errors[:base]).to include('This type of promotion must have a minimum quantity and a discount.')
      end
    end

    describe 'when min_quantity, discount are present and promotion_free_quantity is nil' do
      let(:promotion) { FactoryBot.build(:promotion, promotion_type: 'price_discount_per_quantity', min_quantity: 3, discount: 4.50, promotion_free_quantity: nil) }

      it 'valid' do
        expect(promotion).to be_valid
      end

      it 'sets the attribute correctly' do
        expect(promotion.min_quantity).to eq(3)
        expect(promotion.promotion_free_quantity).to eq(nil)
        expect(promotion.discount).to eq(4.50)
      end
    end
  end

  context 'promotion type: percentage_discount_per_quantity' do
    describe 'when it has promotion_free_quantity' do
      let(:promotion) { FactoryBot.build(:promotion, promotion_type: 'percentage_discount_per_quantity',  min_quantity: 3, discount: 63.33, promotion_free_quantity: 2) }

      it 'not valid' do
        expect(promotion).not_to be_valid
      end

      it 'raises error stating promotion_free_quantity should not be present' do
        promotion.valid?
        expect(promotion.errors[:base]).to include('This type of promotion does not have promotion free quantity.')
      end
    end

    describe 'when min_quantity is not present' do
      let(:promotion) { FactoryBot.build(:promotion, promotion_type: 'percentage_discount_per_quantity',  min_quantity: nil, discount: 63.33, promotion_free_quantity: nil) }

      it 'not valid' do
        expect(promotion).not_to be_valid
      end

      it 'raises error stating it should be present' do
        promotion.valid?
        expect(promotion.errors[:base]).to include('This type of promotion must have a minimum quantity and a discount.')
      end
    end

    describe 'when discount is not present' do
      let(:promotion) { FactoryBot.build(:promotion, promotion_type: 'percentage_discount_per_quantity',  min_quantity: 3, discount: nil, promotion_free_quantity: 2) }

      it 'not valid' do
        expect(promotion).not_to be_valid
      end

      it 'raises error stating it should be present' do
        promotion.valid?
        expect(promotion.errors[:base]).to include('This type of promotion must have a minimum quantity and a discount.')
      end
    end

    describe 'when min_quantity, discount are present and promotion_free_quantity is nil' do
      let(:promotion) { FactoryBot.build(:promotion, promotion_type: 'percentage_discount_per_quantity',  min_quantity: 3, discount: 63.33, promotion_free_quantity: nil) }

      it 'valid' do
        expect(promotion).to be_valid
      end

      it 'sets the attribute correctly' do
        expect(promotion.min_quantity).to eq(3)
        expect(promotion.promotion_free_quantity).to eq(nil)
        expect(promotion.discount).to eq(63.33)
      end
    end
  end

  context '#validate_promotion' do
    describe 'when promotion type is buy_x_get_x_free and the promotion was applied correctly' do
      let(:cart) { FactoryBot.create(:cart, total: 3.11) }
      let(:product) { FactoryBot.create(:product, code: 'GR1', name: 'Green Tea', price: 3.11) }
      let(:cart_item) { FactoryBot.create(:cart_item, cart_id: cart.id, product_id: product.id, quantity: 1, free_quantity: 1, undiscounted_price: 6.12, discounted_price: 3.11) }
      let(:promotion) do
        FactoryBot.create(
          :promotion,
          title: 'Green Tea Promotion',
          product_code: 'GR1',
          promotion_type: 'buy_x_get_x_free',
          discount: nil,
          min_quantity: 1,
          promotion_free_quantity: 1
        )
      end

      it 'returns true' do
        expect(promotion.validate_promotion(cart_item)).to eq(true)
      end
    end

    describe 'when promotion type is buy_x_get_x_free and the promotion was applied incorrectly' do
      let(:cart) { FactoryBot.create(:cart, total: 3.11) }
      let(:product) { FactoryBot.create(:product, code: 'GR1', name: 'Green Tea', price: 3.11) }
      let(:cart_item) { FactoryBot.create(:cart_item, cart_id: cart.id, product_id: product.id, quantity: 2, free_quantity: 1, undiscounted_price: 6.12, discounted_price: 3.11) }
      let(:promotion) do
        FactoryBot.create(
          :promotion,
          title: 'Green Tea Promotion',
          product_code: 'GR1',
          promotion_type: 'buy_x_get_x_free',
          discount: nil,
          min_quantity: 1,
          promotion_free_quantity: 1
        )
      end

      it 'returns true' do
        expect(promotion.validate_promotion(cart_item)).to eq(false)
      end
    end

    describe 'when promotion type is price_discount_per_quantity and the promotion was applied correctly' do
      let(:cart) { FactoryBot.create(:cart, total: 13.50) }
      let(:product) { FactoryBot.create(:product, code: 'SR1', name: 'Strawberries', price: 5.00) }
      let(:cart_item) { FactoryBot.create(:cart_item, cart_id: cart.id, product_id: product.id, quantity: 3, free_quantity: nil, undiscounted_price: 15.00, discounted_price: 13.50) }
      let(:promotion) do
        FactoryBot.create(
          :promotion,
          title: 'Strawberrie Promotion',
          product_code: 'SR1',
          promotion_type: 'price_discount_per_quantity',
          discount: 4.50,
          min_quantity: 3,
          promotion_free_quantity: nil
        )
      end

      it 'returns true' do
        expect(promotion.validate_promotion(cart_item)).to eq(true)
      end
    end

    describe 'when promotion type is price_discount_per_quantity and the promotion was applied incorrectly' do
      let(:cart) { FactoryBot.create(:cart, total: 13.50) }
      let(:product) { FactoryBot.create(:product, code: 'SR1', name: 'Strawberries', price: 5.00) }
      let(:cart_item) { FactoryBot.create(:cart_item, cart_id: cart.id, product_id: product.id, quantity: 3, free_quantity: nil, undiscounted_price: 15.00, discounted_price: 12.50) }
      let(:promotion) do
        FactoryBot.create(
          :promotion,
          title: 'Strawberrie Promotion',
          product_code: 'SR1',
          promotion_type: 'price_discount_per_quantity',
          discount: 4.50,
          min_quantity: 3,
          promotion_free_quantity: nil
        )
      end

      it 'returns true' do
        expect(promotion.validate_promotion(cart_item)).to eq(false)
      end
    end

    describe 'when promotion type is percentage_discount_per_quantity and the promotion was applied correctly' do
      let(:cart) { FactoryBot.create(:cart, total: 22.46) }
      let(:product) { FactoryBot.create(:product, code: 'CF1', name: 'Coffee', price: 11.23) }
      let(:cart_item) { FactoryBot.create(:cart_item, cart_id: cart.id, product_id: product.id, quantity: 3, free_quantity: nil, undiscounted_price: 33.69, discounted_price: 22.46) }
      let(:promotion) do
        FactoryBot.create(
          :promotion,
          title: 'Coffee Promotion',
          product_code: 'CF1',
          promotion_type: 'percentage_discount_per_quantity',
          discount: (2.0 / 3.0),
          min_quantity: 3,
          promotion_free_quantity: nil
        )
      end

      it 'returns true' do
        expect(promotion.validate_promotion).to eq(true)
      end
    end

    describe 'when promotion type is percentage_discount_per_quantity and the promotion was applied correctly' do
      let(:cart) { FactoryBot.create(:cart, total: 22.46) }
      let(:product) { FactoryBot.create(:product, code: 'CF1', name: 'Coffee', price: 11.23) }
      let(:cart_item) { FactoryBot.create(:cart_item, cart_id: cart.id, product_id: product.id, quantity: 3, free_quantity: nil, undiscounted_price: 33.69, discounted_price: 21.46) }
      let(:promotion) do
        FactoryBot.create(
          :promotion,
          title: 'Coffee Promotion',
          product_code: 'CF1',
          promotion_type: 'percentage_discount_per_quantity',
          discount: (2.0 / 3.0),
          min_quantity: 3,
          promotion_free_quantity: nil
        )
      end

      it 'returns true' do
        expect(promotion.validate_promotion).to eq(false)
      end
    end
  end


  context '#validate_buy_x_get_x_free' do
    describe 'when promotion is applied correctly' do
      let(:cart) { FactoryBot.create(:cart, total: 3.11) }
      let(:product) { FactoryBot.create(:product, code: 'GR1', name: 'Green Tea', price: 3.11) }
      let(:cart_item) { FactoryBot.create(:cart_item, cart_id: cart.id, product_id: product.id, quantity: 1, free_quantity: 1, undiscounted_price: 6.12, discounted_price: 3.11) }
      let(:promotion) do
        FactoryBot.create(
          :promotion,
          title: 'Green Tea Promotion',
          product_code: 'GR1',
          promotion_type: 'buy_x_get_x_free',
          discount: nil,
          min_quantity: 1,
          promotion_free_quantity: 1
        )
      end

      it 'returns true' do
        expect(promotion.validate_buy_x_get_x_free(cart_item)).to eq(true)
      end
    end

    describe 'when promotion in not applied correctly and it has a different discounted_price' do
      let(:cart) { FactoryBot.create(:cart, total: 3.11) }
      let(:product) { FactoryBot.create(:product, code: 'GR1', name: 'Green Tea', price: 3.11) }
      let(:cart_item) { FactoryBot.create(:cart_item, cart_id: cart.id, product_id: product.id, quantity: 1, free_quantity: 1, undiscounted_price: 6.12, discounted_price: 3.20) }
      let(:promotion) do
        FactoryBot.create(
          :promotion,
          title: 'Green Tea Promotion',
          product_code: 'GR1',
          promotion_type: 'buy_x_get_x_free',
          discount: nil,
          min_quantity: 1,
          promotion_free_quantity: 1
        )
      end

      it 'returns false' do
        expect(promotion.validate_buy_x_get_x_free(cart_item)).to eq(false)
      end
    end

    describe 'when promotion in not applied correctly and it has a different free_quantity' do
      let(:cart) { FactoryBot.create(:cart, total: 3.11) }
      let(:product) { FactoryBot.create(:product, code: 'GR1', name: 'Green Tea', price: 3.11) }
      let(:cart_item) { FactoryBot.create(:cart_item, cart_id: cart.id, product_id: product.id, quantity: 1, free_quantity: 2, undiscounted_price: 6.12, discounted_price: 3.11) }
      let(:promotion) do
        FactoryBot.create(
          :promotion,
          title: 'Green Tea Promotion',
          product_code: 'GR1',
          promotion_type: 'buy_x_get_x_free',
          discount: nil,
          min_quantity: 1,
          promotion_free_quantity: 1
        )
      end

      it 'returns false' do
        expect(promotion.validate_buy_x_get_x_free(cart_item)).to eq(false)
      end
    end

    describe 'when promotion in not applied correctly and it has a different quantity' do
      let(:cart) { FactoryBot.create(:cart, total: 3.11) }
      let(:product) { FactoryBot.create(:product, code: 'GR1', name: 'Green Tea', price: 3.11) }
      let(:cart_item) { FactoryBot.create(:cart_item, cart_id: cart.id, product_id: product.id, quantity: 2, free_quantity: 1, undiscounted_price: 6.12, discounted_price: 3.11) }
      let(:promotion) do
        FactoryBot.create(
          :promotion,
          title: 'Green Tea Promotion',
          product_code: 'GR1',
          promotion_type: 'buy_x_get_x_free',
          discount: nil,
          min_quantity: 1,
          promotion_free_quantity: 1
        )
      end

      it 'returns false' do
        expect(promotion.validate_buy_x_get_x_free(cart_item)).to eq(false)
      end
    end
  end

  context '#validate_price_discount_per_quantity' do
    describe 'when promotion is applied correctly' do
      let(:cart) { FactoryBot.create(:cart, total: 13.50) }
      let(:product) { FactoryBot.create(:product, code: 'SR1', name: 'Strawberries', price: 5.00) }
      let(:cart_item) { FactoryBot.create(:cart_item, cart_id: cart.id, product_id: product.id, quantity: 3, free_quantity: nil, undiscounted_price: 15.00, discounted_price: 13.50) }
      let(:promotion) do
        FactoryBot.create(
          :promotion,
          title: 'Strawberrie Promotion',
          product_code: 'SR1',
          promotion_type: 'price_discount_per_quantity',
          discount: 4.50,
          min_quantity: 3,
          promotion_free_quantity: nil
        )
      end

      it 'returns true' do
        expect(promotion.validate_price_discount_per_quantity(cart_item)).to eq(true)
      end
    end

    describe 'when promotion in not applied correctly and it has a different discounted_price' do
      let(:cart) { FactoryBot.create(:cart, total: 13.50) }
      let(:product) { FactoryBot.create(:product, code: 'SR1', name: 'Strawberries', price: 5.00) }
      let(:cart_item) { FactoryBot.create(:cart_item, cart_id: cart.id, product_id: product.id, quantity: 3, free_quantity: nil, undiscounted_price: 15.00, discounted_price: 12.50) }
      let(:promotion) do
        FactoryBot.create(
          :promotion,
          title: 'Strawberrie Promotion',
          product_code: 'SR1',
          promotion_type: 'price_discount_per_quantity',
          discount: 4.50,
          min_quantity: 3,
          promotion_free_quantity: nil
        )
      end

      it 'returns false' do
        expect(promotion.validate_price_discount_per_quantity(cart_item)).to eq(false)
      end
    end
  end

  context '#validate_percentage_discount_per_quantity' do
    describe 'when promotion is applied correctly' do
      let(:cart) { FactoryBot.create(:cart, total: 22.46) }
      let(:product) { FactoryBot.create(:product, code: 'CF1', name: 'Coffee', price: 11.23) }
      let(:cart_item) { FactoryBot.create(:cart_item, cart_id: cart.id, product_id: product.id, quantity: 3, free_quantity: nil, undiscounted_price: 33.69, discounted_price: 22.46) }
      let(:promotion) do
        FactoryBot.create(
          :promotion,
          title: 'Coffee Promotion',
          product_code: 'CF1',
          promotion_type: 'percentage_discount_per_quantity',
          discount: (2.0 / 3.0),
          min_quantity: 3,
          promotion_free_quantity: nil
        )
      end

      it 'returns true' do
        expect(promotion.validate_percentage_discount_per_quantity(cart_item)).to eq(true)
      end
    end

    describe 'when promotion in not applied correctly and it has a different discounted_price' do
      let(:cart) { FactoryBot.create(:cart, total: 20.35) }
      let(:product) { FactoryBot.create(:product, code: 'CF1', name: 'Coffee', price: 11.23) }
      let(:cart_item) { FactoryBot.create(:cart_item, cart_id: cart.id, product_id: product.id, quantity: 3, free_quantity: nil, undiscounted_price: 33.69, discounted_price: 20.35) }
      let(:promotion) do
        FactoryBot.create(
          :promotion,
          title: 'Coffee Promotion',
          product_code: 'CF1',
          promotion_type: 'percentage_discount_per_quantity',
          discount: 67.00,
          min_quantity: 3,
          promotion_free_quantity: nil
        )
      end

      it 'returns false' do
        expect(promotion.validate_percentage_discount_per_quantity(cart_item)).to eq(false)
      end
    end
  end
end
