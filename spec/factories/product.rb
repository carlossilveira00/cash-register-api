FactoryBot.define do
  factory :product do
    code { 'SR1' }
    name { 'Strawberries' }
    price { 5.00 }
    image_url { 'https://images.unsplash.com/photo-1464965911861-746a04b4bca6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80' }
  end
end
