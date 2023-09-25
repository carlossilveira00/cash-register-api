FactoryBot.define do
  factory :promotion do
    title { 'Green Tea Promotion' }
    product_code { 'GR1' }
    promotion_type { 'buy_x_get_x_free' }
    discount { nil }
    min_quantity { 1 }
    promotion_free_quantity { 1 }
  end
end
