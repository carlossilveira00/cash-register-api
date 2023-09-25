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

end
