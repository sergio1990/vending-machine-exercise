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

  def coin_by_code(coin_code)
    available_coins.find do |coin|
      coin.code == coin_code
    end
  end
end
