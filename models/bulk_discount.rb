# frozen_string_literal: true

require_relative 'product'
require_relative 'discount'

# bulk discount, this will deduct a fixed amount (cents) from the cart, for each X quantity of certain product
# eg: a bulk discount of $10 that will be applied for every 2 apples in the cart, if the cart has 5 apples, $20 ($10x2) will be deducted from the cart total

class BulkDiscount < Discount

  attr_reader :amount, :quantity_required, :product_name

  def initialize(amount, quantity_required, product_name)
    @amount = amount
    @quantity_required = quantity_required
    @product_name = product_name
  end

  # this should return the cart total (in cents, integer) after the discount is applied
  def apply(total, products)
    qualified_products = products.select{ |product| product.name == product_name }
    amount_to_deduct = (qualified_products.count / quantity_required) * @amount

    total - amount_to_deduct
  end
end