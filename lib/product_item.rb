# frozen_string_literal: true

require 'forwardable'

class ProductItem
  extend Forwardable

  attr_reader :product, :amount

  def_delegator :product, :id, :product_id
  def_delegator :product, :name, :product_name
  def_delegator :product, :price, :product_price

  def initialize(product, amount)
    @product = product
    @amount = amount
  end

  def substract_amount
    @amount -= 1
  end
end
