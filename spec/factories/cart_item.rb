FactoryBot.define do
  factory :cart_item do
    association :cart
    association :product
    quantity { 1 }
    undiscounted_price { product.price * quantity }
    discounted_price { nil }
  end
end
