# frozen_string_literal: true

Dir[File.dirname(__FILE__) + '/lib/**/*.rb'].each { |file| require file }

available_coins = [
  Coin.new('25c', 25),
  Coin.new('50c', 50),
  Coin.new('1', 100),
  Coin.new('2', 200),
  Coin.new('5', 500)
].freeze

products = [
  Product.new(1, 'Nachos', 200),
  Product.new(2, 'Animal cracker', 75),
  Product.new(3, 'Potato chips', 225)
].freeze

vending_machine = VendingMachine.new(
  products,
  available_coins
)

app = Application.new(
  vending_machine,
  Facing::ConsoleInput.new,
  Facing::ConsoleOutput.new
)

app.start
