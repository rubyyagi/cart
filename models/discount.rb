# frozen_string_literal: true

require_relative 'product'

class Discount
  # total [Integer] the current total (in cents) of the cart before applying the current discount
  # products [Array<product>] array of products in the cart

  # this should return the cart total after the discount is applied (in cents, integer)
  def apply(_total, _products)
    raise 'Not implemented'
    # implemented this on the subclass of Discount
  end
end
