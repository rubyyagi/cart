# frozen_string_literal: true

require_relative 'product'
require_relative 'discount'

# cart discount, this will deduct a fixed percentage from the cart total
# one cart can only have one cart percentage discount, and must be applied at the last (ie. applied after all other discounts are applied)
# the percentage discount will only be applied, if the cart total (after all previous discount has been applied) is larger or equal to the minimum amount required
class CartPercentageDiscount < Discount

  attr_reader :percentage, :minimum_cart_total

  # percentage, eg: 50 means 50% off
  def initialize(percentage, minimum_cart_total)
    @percentage = percentage
    @minimum_cart_total = minimum_cart_total
  end

  # this should return the cart total (in cents, integer) after the discount is applied
  def apply(total, products)
    return total if total < @minimum_cart_total

    total * (100 -  @percentage) / 100.0
  end
end