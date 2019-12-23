# frozen_string_literal: true

class Purchase
  attr_reader :product, :coins

  def initialize(product)
    @product = product
    @coins = []
  end
end
