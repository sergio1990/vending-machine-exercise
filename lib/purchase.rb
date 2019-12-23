# frozen_string_literal: true

require 'forwardable'

class Purchase
  extend Forwardable

  def_delegator :product, :name, :product_name

  def initialize(product)
    @product = product
    @coins = []
  end

  def add_coin(coin)
    coins << coin
  end

  def enough_coins_to_buy?
    coins_sum >= product.price
  end

  def waiting_amount
    product.price - coins_sum
  end

  def need_to_get_change?
    coins_sum > product.price
  end

  def change_amount
    coins_sum - product.price
  end

  private

  attr_reader :product, :coins

  def coins_sum
    coins.inject(0) { |sum, c| sum + c.value }
  end
end
