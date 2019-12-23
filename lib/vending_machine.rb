# frozen_string_literal: true

require 'forwardable'

class VendingMachine
  extend Forwardable

  attr_reader :products, :available_coins

  def_delegator :coin_factory, :supported_coin_codes

  def initialize(products, available_coins, coin_factory)
    @products = products
    @available_coins = available_coins
    @coin_factory = coin_factory
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

  private

  attr_reader :coin_factory
end
