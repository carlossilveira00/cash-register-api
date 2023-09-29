puts "Seed the Database."

puts "_____________"

puts "Creating the Products:"
Product.create(
  code: 'GR1',
  name: 'Green Tea',
  price: 3.11,
  image_url: 'https://images.unsplash.com/photo-1627435601361-ec25f5b1d0e5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2940&q=80'
)

Product.create(
  code: 'SR1',
  name: 'Strawberries',
  price: 5.0,
  image_url: 'https://images.unsplash.com/photo-1622921491193-345ffb510f6f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2942&q=80'
)

Product.create(
  code: 'CF1',
  name: 'Coffee',
  price: 11.23,
  image_url: 'https://images.unsplash.com/photo-1512568400610-62da28bc8a13?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=3087&q=80'
)

puts "_____________"

puts "Creating the Promotions:"

Promotion.create(
  title: 'Buy 1 get 1 free!',
  product_code: 'GR1',
  promotion_type: 'buy_x_get_x_free',
  min_quantity: 1,
  promotion_free_quantity: 1
)

Promotion.create(
  title: 'Buy 3 or more and all cost 4.5!',
  product_code: 'SR1',
  promotion_type: 'price_discount_per_quantity',
  discount: 4.5,
  min_quantity: 3
)

Promotion.create(
  title: 'Buy 3 or more and get 2/3 of discount!',
  product_code: 'CF1',
  promotion_type: 'percentage_discount_per_quantity',
  discount: 2.0/3.0,
  min_quantity: 3
)

puts "Done! You are ready to start the server!"
