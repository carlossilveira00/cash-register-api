FactoryBot.define do
  factory :promotion do
    title { "MyString" }
    product_code { "MyString" }
    type { "" }
    discount { 1.5 }
    min_quantity { 1 }
    promotion_free_quantity { "MyString" }
    integer { "MyString" }
  end
end
