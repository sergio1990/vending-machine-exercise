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
    coins = coins_in_bank.inject([]) do |accumulator, (coin_code, amount)|
      accumulator.concat(Array.new(amount, coin_factory.build_by_code(coin_code)))
    end
    change_calculator = ChangeCalculator.new(
      425,
      coins
    )

    change_result = change_calculator.calculate

    assert_equal true, change_result.full_change
    assert_equal 6, change_result.coins.count

    grouped_change_coins = change_result.coins.group_by { |c| c.code }
    assert_equal 1, grouped_change_coins['2'].count
    assert_equal 4, grouped_change_coins['50c'].count
    assert_equal 1, grouped_change_coins['25c'].count
  end

  def test_not_enough_coins_to_cover_the_change
    coins_in_bank = {
      '50c' => 4,
      '2' => 1
    }
    coins = coins_in_bank.inject([]) do |accumulator, (coin_code, amount)|
      accumulator.concat(Array.new(amount, coin_factory.build_by_code(coin_code)))
    end
    change_calculator = ChangeCalculator.new(
      425,
      coins
    )

    change_result = change_calculator.calculate

    assert_equal false, change_result.full_change
    assert_equal 5, change_result.coins.count
    assert_equal 25, change_result.change_amount

    grouped_change_coins = change_result.coins.group_by { |c| c.code }
    assert_equal 1, grouped_change_coins['2'].count
    assert_equal 4, grouped_change_coins['50c'].count
  end

  private

  def coin_factory
    @coin_factory ||= coin_factory = CoinFactory.new(SUPPORTED_COINS)
  end
end
