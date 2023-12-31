require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'validates product.code' do
    describe 'when product.code is nil' do
      let(:product) { FactoryBot.build(:product, code: nil) }

      it 'not valid' do
        expect(product).not_to be_valid
      end
    end

    describe 'when product.code is not a string' do
      let(:product) { FactoryBot.build(:product, code: 5.99) }

      it 'not valid' do
        expect(product).not_to be_valid
      end
    end

    describe 'when product.code is blank' do
      let(:product) { FactoryBot.build(:product, code: '') }

      it 'not valid' do
        expect(product).not_to be_valid
      end
    end

    describe 'when product.code is a string' do
      let(:product) { FactoryBot.build(:product) }

      it 'valid' do
        expect(product).to be_valid
      end

      it 'sets the correct product.code' do
        expect(product.code).to eq('SR1')
      end
    end
  end

  context 'validates product.name' do
    describe 'when product.name is nil' do
      let(:product) { FactoryBot.build(:product, name: nil) }

      it 'not valid' do
        expect(product).not_to be_valid
      end
    end

    describe 'when product.name is not a string' do
      let(:product) { FactoryBot.build(:product, name: 5.99) }

      it 'not valid' do
        expect(product).not_to be_valid
      end
    end

    describe 'when product.name is blank' do
      let(:product) { FactoryBot.build(:product, name: '') }

      it 'not valid' do
        expect(product).not_to be_valid
      end
    end

    describe 'when product.name is a string' do
      let(:product) { FactoryBot.build(:product, name: 'Strawberries') }

      it 'valid' do
        expect(product).to be_valid
      end

      it 'sets the correct product.name' do
        expect(product.name).to eq('Strawberries')
      end
    end
  end

  context 'validates product.price' do
    describe 'when product.price is nil' do
      let(:product) { FactoryBot.build(:product, price: nil) }

      it 'not valid' do
        expect(product).not_to be_valid
      end
    end

    describe 'when product.price is not a float' do
      let(:product) { FactoryBot.build(:product, price: '2 dollars') }

      it 'not valid' do
        expect(product).not_to be_valid
      end
    end

    describe 'when product.price is a float' do
      let(:product) { FactoryBot.build(:product, price: 4.99) }

      it 'valid' do
        expect(product).to be_valid
      end

      it 'sets the correct product.price' do
        expect(product.price).to eq(4.99)
      end
    end
  end

  context 'validates product.image_url' do
    describe 'when product.image_url is nil' do
      let(:product) { FactoryBot.build(:product, image_url: nil) }

      it 'not valid' do
        expect(product).not_to be_valid
      end
    end

    describe 'when product.image_url is present' do
      let(:product) { FactoryBot.build(:product, image_url: 'https://images.unsplash.com/photo-1464965911861-746a04b4bca6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80') }

      it 'valid' do
        expect(product).to be_valid
      end

      it 'sets the correct product.image_url' do
        expect(product.image_url).to eq('https://images.unsplash.com/photo-1464965911861-746a04b4bca6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80')
      end
    end
  end
end
