# frozen_string_literal: true

require 'forwardable'
require 'securerandom'

class VendingMachine
  InvalidProductCodeError = Class.new(::StandardError)
  OutOfStockError = Class.new(::StandardError)
  InvalidCoinError = Class.new(::StandardError)

  extend Forwardable

  attr_reader :available_coins, :assortment

  def_delegator :coin_factory, :supported_coin_codes

  def initialize(assortment, available_coins, coin_factory)
    @assortment = assortment
    @available_coins = available_coins
    @coin_factory = coin_factory
    @purchases = {}
  end

  def purchase(product_id)
    product_item = product_item_by_product_id(product_id)
    raise InvalidProductCodeError, "There is no product with id ##{product_id}" unless product_item
    raise OutOfStockError, "No more product with id ##{product_id}" if product_item.amount.zero?

    purchase_id = SecureRandom.hex
    purchases[purchase_id] = Purchase.new(product_item.product)
    product_item.substract_amount
    purchase_id
  end

  def enough_coins?(purchase_id)
    purchase = purchases.fetch(purchase_id)
    purchase.enough_coins_to_buy?
  end

  def waiting_amount(purchase_id)
    purchase = purchases.fetch(purchase_id)
    purchase.waiting_amount
  end

  def insert_coin(coin_code, purchase_id)
    purchase = purchases.fetch(purchase_id)
    return false if purchase.enough_coins_to_buy?

    coin = coin_factory.build_by_code(coin_code)
    purchase.add_coin(coin)
    available_coins << coin.dup
    !purchase.enough_coins_to_buy?
  rescue CoinFactory::UnsupportedCoinError => e
    raise InvalidCoinError, e.message
  end

  private

  attr_reader :coin_factory, :purchases

  def product_item_by_product_id(product_id)
    assortment.find do |product_item|
      product_item.product_id == product_id.to_i
    end
  end
end
