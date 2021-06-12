# frozen_string_literal: true

require_relative 'product'
require_relative 'discount'

# bulk discount, this will deduct a fixed amount (cents) from the cart, for each X quantity of certain product
# eg: a bulk discount of $10 (amount = 1000, this is in cents) that will be applied for every 2 apples (quantity required = 2) in the cart, 
# if the cart has 5 apples, $20 ($10x2) will be deducted from the cart total

class BulkDiscount < Discount

  # amount means the discounted amount is in cents (ie. -$10 off means amount = 1000)
  attr_reader :amount, :quantity_required, :product_name

  def initialize(amount:, quantity_required:, product_name:)
    @amount = amount
    @quantity_required = quantity_required
    @product_name = product_name
  end

  # this should return the cart total (in cents, integer) after the discount is applied
  def apply(total, products)
    qualified_product = products.select{ |product| product.name == product_name }.first

    amount_to_deduct = 0

    if qualified_product
      amount_to_deduct = (qualified_product.quantity / quantity_required) * @amount
    end

    [total - amount_to_deduct, 0].max
  end
end