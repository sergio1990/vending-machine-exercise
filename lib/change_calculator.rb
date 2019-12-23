class ChangeCalculator
  Result = Struct.new(:full_change, :coins, :change_amount)

  def initialize(change_amount, coins)
    @change_amount = change_amount
    @coins = coins
  end

  def calculate
    change_coins = []
    coin_values = @coins.map(&:value).uniq.sort { |a, b| b <=> a }
    while coin_values.count.positive? && @change_amount.positive?
      coin_value = coin_values.first
      coin = @coins.find { |c| c.value == coin_value }
      if coin && (coin_value <= @change_amount)
        @change_amount -= coin_value
        change_coins << coin.dup
        @coins.delete_at(@coins.index(coin))
      else
        coin_values = coin_values[1..-1]
      end
    end
    Result.new(@change_amount.zero?, change_coins, @change_amount)
  end
end
