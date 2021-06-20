require 'sinatra'
require 'json'

require_relative 'models/cart'
require_relative 'models/product'
require_relative 'models/bulk_discount'

get '/' do
  erb :index
end

get '/checkout' do
  erb :checkout
end

post '/checkout' do
  # the products name are all in lowercase, 'apple', 'orange' and 'banana'
  products = params[:products].map do |product_param|
    Product.new(name: product_param[:name], unit_price_cents: product_param[:price].to_i * 100,
                quantity: product_param[:quantity].to_i)
  end.select { |product| product.quantity > 0 }

  discounts = [
    BulkDiscount.new(amount: 100, quantity_required: 3, product_name: 'apple'),
    BulkDiscount.new(amount: 200, quantity_required: 2, product_name: 'banana')
  ]

  cart = Cart.new(discounts: discounts, products: products)

  erb :checkout,
      locals: { products: products, total: cart.total_formatted, discount: cart.discount_formatted,
                has_discount: cart.has_discount? }
end
