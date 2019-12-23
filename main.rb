# frozen_string_literal: true

Dir[File.dirname(__FILE__) + '/lib/**/*.rb'].each { |file| require file }

SUPPORTED_COINS = {
  '25c' => 25,
  '50c' => 50,
  '1'   => 100,
  '2'   => 200,
  '5'   => 500
}.freeze

coin_factory = CoinFactory.new(SUPPORTED_COINS)

available_coins = SUPPORTED_COINS.keys.inject([]) do |coins, coin_code|
  coins.concat(Array.new(rand(10), coin_factory.build_by_code(coin_code)))
end

puts available_coins

products = [
  Product.new(1, 'Nachos', 200),
  Product.new(2, 'Animal cracker', 75),
  Product.new(3, 'Potato chips', 225)
].freeze

vending_machine = VendingMachine.new(
  products,
  available_coins,
  coin_factory
)

app = Application.new(
  vending_machine,
  Facing::ConsoleInput.new,
  Facing::ConsoleOutput.new
)

app.start
