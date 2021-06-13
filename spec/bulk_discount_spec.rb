# frozen_string_literal: true

require_relative '../models/bulk_discount'
require_relative '../models/product'

RSpec.describe BulkDiscount, type: :model do
  let(:bulk_discount_apple) { BulkDiscount.new(amount: 100, quantity_required: 3, product_name: 'apple') }
  let(:bulk_discount_banana) { BulkDiscount.new(amount: 200, quantity_required: 2, product_name: 'banana') }

  let(:apple) { Product.new(name: 'apple', unit_price_cents: 300, quantity: 7) }
  let(:banana) { Product.new(name: 'banana', unit_price_cents: 500, quantity: 5) }

  describe '#apply' do
    it 'apply the discount and reduce the total' do
      # 300 * 7 + 500 * 5 = 4600
      original_total = apple.total_price_cents + banana.total_price_cents

      # 4600 - (100 * 2) = 4400 , as the apple bulk discount is applied two times 
      discounted_total = bulk_discount_apple.apply(original_total, [apple, banana])

      expect(discounted_total).to eq(4400)

      # 4400 - (200 * 2) = 4000 , as the banana bulk discount is applied two times
      discounted_total = bulk_discount_banana.apply(discounted_total, [apple, banana])

      expect(discounted_total).to eq(4000)
    end
  end
end
