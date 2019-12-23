require "minitest/autorun"

require 'coin_factory'
require 'change_calculator'

SUPPORTED_COINS = {
  '25c' => 25,
  '50c' => 50,
  '1'   => 100,
  '2'   => 200,
  '5'   => 500
}.freeze

class ChangeCalculatorTest < Minitest::Test
  def test_proper_change_calculation_1
    coins_in_bank = {
      '25c' => 5,
      '50c' => 4,
      '2' => 1
    }
    coins = coins_in_bank.inject([]) do |coins, (coin_code, amount)|
      coins.concat(Array.new(amount, coin_factory.build_by_code(coin_code)))
    end
    change_calculator = ChangeCalculator.new(
      425,
      coins
    )
    change_coins = change_calculator.calculate
    assert_equal 6, change_coins.count
  end

  private

  def coin_factory
    @coin_factory ||= coin_factory = CoinFactory.new(SUPPORTED_COINS)
  end
end
