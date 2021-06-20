# frozen_string_literal: true

# Product that will be be added to the cart
class Product
  attr_reader :name
  attr_accessor :unit_price_cents, :quantity

  # cents means the price in cents (smallest unit), if the product price is $34.50, the price in cents (integer) is 3450,
  # this is to avoid using decimal / floating point for price data

  # @name [String] the name of the Product
  # @unit_price_cents [Integer] the unit price of the product, in cents
  # @quantity [Integer] quantity placed for the product

  def initialize(name:, unit_price_cents:, quantity: 1)
    @name = name
    @unit_price_cents = unit_price_cents
    @quantity = quantity
  end

  def total_price_cents
    @unit_price_cents * @quantity
  end

  # display price in '$1.60' for 160 cents
  def price_formatted
    decimal_price = (@unit_price_cents * @quantity / 100.to_f)
    '$%.2f' % decimal_price
  end
end
