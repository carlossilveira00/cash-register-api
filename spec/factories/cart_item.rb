FactoryBot.define do
  factory :cart_item do
    association :cart
    association :product
    quantity { 1 }
    free_quantity { nil }
    undiscounted_price { product.price * quantity }
    discounted_price { nil }
  end
end
