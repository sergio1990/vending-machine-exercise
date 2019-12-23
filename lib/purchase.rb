# frozen_string_literal: true

class Purchase
  def initialize(product)
    @product = product
    @coins = []
  end

  private

  attr_reader :product, :coins
end
