# frozen_string_literal: true

class VendingMachine
  attr_reader :products, :available_coins

  def initialize(products, available_coins)
    @products = products
    @available_coins = available_coins
  end

  def product_by_id(product_id)
    products.find do |product|
      product.id == product_id.to_i
    end
  end
end
