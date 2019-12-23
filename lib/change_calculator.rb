class ChangeCalculator
  def initialize(change_amount, coins)
    @change_amount = change_amount
    @coins = coins
  end

  def calculate
    Array.new(6, nil)
  end

  private

  attr_reader :change_amount, :coins
end
