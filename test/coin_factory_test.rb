class CoinFactoryTest < Minitest::Test
  def test_supported_coin_codes
    assert_equal ['25c', '2'], coin_factory.supported_coin_codes
  end

  def test_build_by_code_when_passing_supported_code
    coin = coin_factory.build_by_code('25c')
    assert_equal 25, coin.value
  end

  def test_build_by_code_raises_exception_when_passing_unsupported_code
    assert_raises CoinFactory::UnsupportedCoinError do
      coin_factory.build_by_code('50c')
    end
  end

  private

  def coin_factory
    @coin_factory = CoinFactory.new({
      '25c' => 25,
      '2' => 200
    })
  end
end
