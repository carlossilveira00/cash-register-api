require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'validates product.code' do
    describe "when product.code is nil" do
      let(:product) { Product.new(code: nil, name: "Strawberries", price: 5.00, image_url: "https://images.unsplash.com/photo-1464965911861-746a04b4bca6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80")}

      it "is not valid" do
        expect(product).not_to be_valid
      end
    end

    describe "when product.code is not a string" do
      let(:product) { Product.new(code: 5.99, name: "Strawberries", price: 5.00, image_url: "https://images.unsplash.com/photo-1464965911861-746a04b4bca6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80")}

      it "is not valid" do
        expect(product).not_to be_valid
      end
    end

    describe "when product.code is blank" do
      let(:product) { Product.new(code: '', name: "Strawberries", price: 5.00, image_url: "https://images.unsplash.com/photo-1464965911861-746a04b4bca6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80")}

      it "is not valid" do
        expect(product).not_to be_valid
      end
    end

    describe "when product.code is a string" do
      let(:product) { Product.new(code: 'SR1', name: "Strawberries", price: 5.00, image_url: "https://images.unsplash.com/photo-1464965911861-746a04b4bca6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80")}

      it "is valid" do
        expect(product).to be_valid
      end

      it "sets the correct product.code" do
        expect(product.code).to eq('SR1')
      end
    end
  end


end
