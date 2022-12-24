class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  def index
    @cart_items = current_customer.cart_items
    @total_price = 0

  end

  def update
    cart_items = CartItem.find(params[:id])
    cart_items.update(cart_item_params)
    redirect_to public_cart_items_path
  end

  def destroy
     cart_items = CartItem.find(params[:id])
     cart_items.destroy
    redirect_to '/public/cart_items'
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to public_cart_items_path
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.save
    redirect_to public_cart_items_path
  end

   def cart_item_params
    params.require(:cart_item).permit(:amount,:item_id,:customer_id)
   end
end
