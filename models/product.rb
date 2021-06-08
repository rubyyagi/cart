# frozen_string_literal: true

# Product that will be be added to the cart
class Product
  attr_reader :name
  attr_accessor :price_cents, :original_price_cents

  # cents means the price in cents (smallest unit), if the product price is $34.50, the price in cents (integer) is 3450, 
  # this is to avoid using decimal / floating point for price data

  # @name [String] the name of the Product
  # @price_cents [Integer] the price of the product after discounts are applied, 
  #                        this will be the same as original_price_cents if no discounts are applied.
  #                        You should update this value in the discount process

  # @original_price_cents [Integer] the price of the product before discounts are applied, this should left untouched during discount process

  def initialize(name, original_price_cents)
    @name = name
    @price_cents = original_price_cents
    @original_price_cents = original_price_cents
  end
end
