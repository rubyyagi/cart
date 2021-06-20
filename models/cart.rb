# frozen_string_literal: true

require_relative 'product'
require_relative 'bulk_discount'

class Cart
  attr_reader :products, :discounts

  def initialize(discounts:, products: [])
    @discounts = discounts
    @products = products
  end

  def original_total_cents
    @products.reduce(0) { |total, product| total + product.total_price_cents }
  end

  def original_total_formatted
    format('$%.2f', (original_total_cents / 100.to_f))
  end

  def total_cents
    @discounts.reduce(original_total_cents) { |total, discount| discount.apply(total, @products) }
  end

  def total_formatted
    format('$%.2f', (total_cents / 100.to_f))
  end

  def discount_formatted
    format('$%.2f', ((original_total_cents - total_cents) / 100.to_f))
  end

  def has_discount?
    (original_total_cents - total_cents) > 0
  end
end
