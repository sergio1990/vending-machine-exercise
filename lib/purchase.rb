# frozen_string_literal: true

require 'forwardable'

class Purchase
  extend Forwardable

  def_delegator :product, :name, :product_name

  def initialize(product)
    @product = product
    @coins = []
  end

  private

  attr_reader :product, :coins
end
