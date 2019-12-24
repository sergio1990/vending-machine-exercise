require 'purchase'
require 'product'

class PurchaseTest < Minitest::Test
  def test_enough_coins_to_buy_when_no_coins
    purchase = generate_purchase
    assert_equal false, purchase.enough_coins_to_buy?
  end

  def test_enough_coins_to_buy_when_coins_sum_eq_price
    purchase = generate_purchase
    purchase.add_coin(Coin.new('25c', 25))
    assert_equal true, purchase.enough_coins_to_buy?
  end

  def test_enough_coins_to_buy_when_coins_sum_gt_price
    purchase = generate_purchase
    purchase.add_coin(Coin.new('50c', 50))
    assert_equal true, purchase.enough_coins_to_buy?
  end

  def test_waiting_amount
    purchase = generate_purchase
    assert_equal 25, purchase.waiting_amount
  end

  def test_need_to_get_change_when_coins_sum_gt_price
    purchase = generate_purchase
    purchase.add_coin(Coin.new('50c', 50))
    assert_equal true, purchase.need_to_get_change?
  end

  def test_need_to_get_change_when_coins_sum_eq_price
    purchase = generate_purchase
    purchase.add_coin(Coin.new('25c', 25))
    assert_equal false, purchase.need_to_get_change?
  end

  def test_change_amount_when_coins_sum_gt_price
    purchase = generate_purchase
    purchase.add_coin(Coin.new('50c', 50))
    assert_equal 25, purchase.change_amount
  end

  def test_change_amount_when_coins_sum_eq_price
    purchase = generate_purchase
    purchase.add_coin(Coin.new('25c', 25))
    assert_equal 0, purchase.change_amount
  end

  def test_product_name
    purchase = generate_purchase
    assert_equal 'Product Name', purchase.product_name
  end

  private

  def generate_purchase
    Purchase.new(
      Product.new(1, 'Product Name', 25)
    )
  end
end
