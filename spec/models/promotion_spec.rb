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

  context 'validates promotion.type' do
    describe 'when promotion.type is nil' do
      let(:promotion) { FactoryBot.build(:promotion, type: nil) }

      it 'not valid' do
        expect(promotion).not_to be_valid
      end
    end

    describe 'when promotion.type is blank' do
      let(:promotion) { FactoryBot.build(:promotion, type: '') }

      it 'not valid' do
        expect(promotion).not_to be_valid
      end
    end

    describe 'when promotion.type is a different type from the allowed types' do
      let(:promotion) { FactoryBot.build(:promotion, type: 'random_promotion') }

      it 'not valid' do
        expect(promotion).not_to be_valid
      end
    end

    describe 'when promotion.type is one of the allowed types' do
      let(:promotion) { FactoryBot.build(:promotion) }

      it 'valid' do
        expect(promotion).to be_valid
      end

      it 'sets the correct promotion.type' do
        expect(promotion.type).to eq('buy_x_get_x_free')
      end
    end
  end

  context 'promotion type: buy_x_get_x_free' do
    describe 'when it has a discount' do
      let(:promotion) { FactoryBot.build(:promotion, discount: 50.00) }

      it 'not valid' do
        expect(promotion).not_to be_valid
      end
    end

    describe 'when min_quantity is not present' do
      let(:promotion) { FactoryBot.build(:promotion, min_quantity: nil) }

      it 'not valid' do
        expect(promotion).not_to be_valid
      end

      it 'raises error stating it should be present' do
        expect(promotion.errors[:min_quantity]).to include('This type of promotion must have a minimum quantity.')
      end
    end

    describe 'when promotion_free_quantity is not present' do
      let(:promotion) { FactoryBot.build(:promotion, promotion_free_quantity: nil) }

      it 'not valid' do
        expect(promotion).not_to be_valid
      end

      it 'raises error stating it should be present' do
        expect(promotion.errors[:promotion_free_quantity]).to include('This type of promotion must have a promotion free quantity.')
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


end
