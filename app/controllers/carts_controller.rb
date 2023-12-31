class CartsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def checkout
    # Convert cart_params to hash for easy manipulation.
    cart = cart_params.to_h

    # Iterate through each cart_item
    cart[:cart_items].each do |cart_item|
      item = CartItem.new({
        product_id: cart_item[:product_id],
        quantity: cart_item[:quantity],
        undiscounted_price: cart_item[:undiscounted_price],
        discounted_price: cart_item[:discounted_price],
        free_quantity: cart_item[:free_quantity],
        promotion_id: cart_item[:promotion_id],
        promotion_status: cart_item[:promotion_status]
      })

      if item.promotion_status == 'applied'
        # Find the promotion used in the cart_item
        promotion = Promotion.find(item.promotion_id)
        # Check if the promotion was applied correctly
        unless promotion.validate_promotion(item)
          # If it wasnt applied correctly return code 422.
          return render json: { message: 'Unable to proceed, your promotions did not apply correctly.' }, status: :unprocessable_entity
        end
      end
    end

    @cart = Cart.create(total: cart[:total])

    # Create and save cart items in the database.
    cart[:cart_items].each do |cart_item|
      CartItem.create({
        cart_id: @cart.id,
        product_id: cart_item[:product_id],
        quantity: cart_item[:quantity],
        undiscounted_price: cart_item[:undiscounted_price],
        discounted_price: cart_item[:discounted_price],
        free_quantity: cart_item[:free_quantity],
        promotion_id: cart_item[:promotion_id],
        promotion_status: cart_item[:promotion_status]
      })
    end

    # Find Cart by id, and update totat to be the total sent from the client.
    # @cart = Cart.find(cart[:cart_id])
    # @cart.total = cart[:total]
    # Check if the total price of the cart is correct, this method sums the total of all the cart_items associated with this cart.
    if @cart.validate_total_price
      render json: { message: 'Checkout completed successfully.' }, status: :ok
    else
      # If it isn't correct return code 422.
      render json: { message: 'The total price of the cart, seems to not be correct. Please try again.' }, status: :unprocessable_entity
    end
  end
end

 private

 def cart_params
  params.require(:cart).permit(:total, :cart_id, cart_items: [
    :product_id, :quantity, :undiscounted_price, :discounted_price,
    :free_quantity, :promotion_id, :promotion_status,
    :product_image, :product_code, :product_name, :product_price
  ])
end
