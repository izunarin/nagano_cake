class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  enum payment_methods: { credit_card: 0, transfer: 1 }
  
  enum status: { payment_waiting: 0, payment_confirmation: 1,in_production: 2,preparing_delivery: 3,delivered: 4, }
  
  def total_payment
    total = 0
    order_details.each do |order_detail|
      total =total + order_detail.quantity*order_detail.price
    end
    return total
  end
end
