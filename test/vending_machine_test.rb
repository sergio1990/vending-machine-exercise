require 'vending_machine'
require 'product_item'
require 'product'

class VendingMachineTest < Minitest::Test
  def test_purchase_when_pass_invalid_id
    machine = generate_machine
    assert_raises VendingMachine::InvalidProductCodeError do
      machine.purchase(100)
    end
  end

  def test_purchase_when_try_to_purchase_out_of_stock_product
    machine = generate_machine
    assert_raises VendingMachine::OutOfStockError do
      machine.purchase(1)
    end
  end

  def test_insert_coin_when_more_coins_will_be_needed
    machine = generate_machine
    purchase_id = machine.purchase(2)
    result = machine.insert_coin('25c', purchase_id)
    assert_equal true, result
  end

  def test_insert_coin_when_no_more_coins_are_needed
    machine = generate_machine
    purchase_id = machine.purchase(2)
    machine.insert_coin('25c', purchase_id)
    result = machine.insert_coin('50c', purchase_id)
    assert_equal false, result
  end

  def test_insert_coin_when_try_to_insert_unsupported_coin
    machine = generate_machine
    purchase_id = machine.purchase(2)
    assert_raises VendingMachine::InvalidCoinError do
      machine.insert_coin('10c', purchase_id)
    end
  end

  def test_request_change_when_no_enough_coins_in_bank
    machine = generate_machine
    purchase_id = machine.purchase(2)

    insert_result = machine.insert_coin('1', purchase_id)
    assert_equal false, insert_result

    need_change = machine.need_to_get_change?(purchase_id)
    assert_equal true, need_change

    change_result = machine.request_change(purchase_id)
    assert_equal false, change_result.full_change
    assert_equal 25, change_result.change_amount
  end

  def test_request_change_when_there_are_coins_in_bank
    machine = generate_machine(
      [coin_factory.build_by_code('25c')]
    )
    purchase_id = machine.purchase(2)

    insert_result = machine.insert_coin('1', purchase_id)
    assert_equal false, insert_result

    need_change = machine.need_to_get_change?(purchase_id)
    assert_equal true, need_change

    assert_equal 2, machine.available_coins.count

    change_result = machine.request_change(purchase_id)
    assert_equal true, change_result.full_change
    assert_equal 0, change_result.change_amount
    assert_equal 1, change_result.coins.count

    assert_equal 1, machine.available_coins.count
  end

  private

  def generate_machine(coins = [])
    VendingMachine.new(
      assortment,
      coins,
      coin_factory
    )
  end

  def assortment
    @assortment ||= [
      ProductItem.new(Product.new(1, 'Nachos', 200), 0),
      ProductItem.new(Product.new(2, 'Animal cracker', 75), 3),
      ProductItem.new(Product.new(3, 'Potato chips', 225), 2)
    ].freeze
  end

  def coin_factory
    @coin_factory = CoinFactory.new({
      '25c' => 25,
      '50c' => 50,
      '1' => 100
    })
  end
end
