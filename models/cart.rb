# frozen_string_literal: true

require_relative 'product'
require_relative 'bulk_discount'
require_relative 'cart_percentage_discount'

class Cart
  attr_reader :products, :discounts

  def initialize(discounts)
    @discounts = discounts
    @products = []
  end

  def add(product)
    @products << product
  end

  def total
    @discounts.reduce(0) { |total, discount| discount.call(total, @products) }
  end
end