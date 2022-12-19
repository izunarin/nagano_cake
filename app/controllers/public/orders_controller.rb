class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = current_customer

  end

  def confirm
    @order = Order.new(order_params)
    @order.payment_methods = params[:order][:payment_methods].to_i
    if params[:order][:select_address] == "0"
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.last_name+current_customer.first_name
    elsif params[:order][:select_address]=="1"
    @address = Address.find(params[:order][:address_id])
    @order.postal_code = @address.postal_code
    @order.address = @address.address
    @order.name = @address.name
    elsif params[:order][:select_address]!="2"
      @customer = current_customer
      render :new
      return
    end
    @cart_items = current_customer.cart_items
    @total_price = 0
    @shipping_fee = 800
    render :confirm
  end

  def thanks
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save!
    current_customer.cart_items.each do |cart_item|
     order_detail = OrderDetail.new
     order_detail.order_id = @order.id
     order_detail.item_id = cart_item.item_id
     order_detail.price = cart_item.item.price
     order_detail.quantity = cart_item.amount
     order_detail.save!
    end
    current_customer.cart_items.destroy_all
    redirect_to public_orders_withdraw_path
  end

  def index
    @orders = current_customer.orders
    @cart_items = current_customer.cart_items
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    
  end

  private

  def order_params
  params.require(:order).permit(:postal_code, :address, :name,:payment_methods,:billing,:shipping_fee,:status)
  end
end
