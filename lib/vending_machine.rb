# frozen_string_literal: true

class VendingMachine
  attr_reader :products, :available_coins

  def initialize(products, available_coins)
    @products = products
    @available_coins = available_coins
  end
end
