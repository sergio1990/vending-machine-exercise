# frozen_string_literal: true

require_relative './coin'

class CoinFactory
  InvalidCoinCodeError = Class.new(::StandardError)

  def initialize(supported_coins)
    @supported_coins = supported_coins
  end

  def supported_coin_codes
    @supported_coin_codes ||= supported_coins.keys
  end

  def build_by_code(coin_code)
    coin_value = supported_coins.fetch(coin_code)
    Coin.new(coin_code, coin_value)
  rescue KeyError
    raise InvalidCoinCodeError, "There is no coin with the code '#{coin_code}'!"
  end

  private

  attr_reader :supported_coins
end
