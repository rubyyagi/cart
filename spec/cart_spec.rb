# frozen_string_literal: true

require_relative '../models/cart'
require_relative '../models/bulk_discount'
require_relative '../models/product'

RSpec.describe Cart, type: :model do
  let(:bulk_discount_apple) { BulkDiscount.new(amount: 100, quantity_required: 3, product_name: 'apple') }
  let(:bulk_discount_banana) { BulkDiscount.new(amount: 200, quantity_required: 2, product_name: 'banana') }

  let(:apple) { Product.new(name: 'apple', unit_price_cents: 300, quantity: 7) }
  let(:orange) { Product.new(name: 'orange', unit_price_cents: 400, quantity: 2) }
  let(:banana) { Product.new(name: 'banana', unit_price_cents: 500, quantity: 5) }

  let(:cart) { Cart.new(discounts: [bulk_discount_apple, bulk_discount_banana], products: [apple, orange, banana]) }

  # cart that dont have product that is eligible for discount
  let(:ineligible_cart) { Cart.new(discounts: [bulk_discount_apple, bulk_discount_banana], products: [orange]) }

  describe '#original_total_cents' do
    it 'returns the original total without discount applied' do
      # 300 * 7 + 400 * 2 + 500 * 5 = 5400
      expect(cart.original_total_cents).to eq(5400)
    end
  end

  describe '#original_total' do
    it 'returns the original total without discount applied, with dollar sign format of two decimal' do
      # 300 * 7 + 400 * 2 + 500 * 5 = 5400
      expect(cart.original_total_formatted).to eq('$54.00')
    end
  end

  describe '#total_cents' do
    it 'returns the total with discount applied' do
      # 5400 - (2*100) - (2*200) = 4800
      expect(cart.total_cents).to eq(4800)
    end
  end

  describe '#total_cents_formatted' do
    it 'returns the total with discount applied, with dollar sign format of two decimal' do
      # 5400 - (2*100) - (2*200) = 4800
      expect(cart.total_formatted).to eq('$48.00')
    end
  end

  describe '#discounted_formatted' do
    it 'returns the amount that is deducted from the cart, with dollar sign format of two decimal' do
      # 5400 - 4800 = 600
      expect(cart.discount_formatted).to eq('$6.00')
    end
  end

  describe '#has_discount?' do
    it 'returns whether the cart has discount applied' do
      expect(cart.has_discount?).to eq(true)

      # cart with only orange, does not qualify for the bulk discount for apple and banana,
      # hence no discount is applied (ie. total == original_total)
      expect(ineligible_cart.has_discount?).to eq(false)
    end
  end

  describe 'ineligible cart with no products that are qualified for bulk discount' do
    it 'has the same value for original_total_cents and total_cents' do
      expect(ineligible_cart.total_cents).to eq(ineligible_cart.original_total_cents)
    end
  end
end
