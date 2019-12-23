class Application
  include Helpers::HumanPriceHelper

  def initialize(vending_machine, input, output)
    @vending_machine = vending_machine
    @input = input
    @output = output
  end

  def start
    output.prints('> Hi, mate! Welcome to my vending machine!')
    output.prints
    print_available_coins_info
    start_selling_session
    output.prints('>' * 10)
    output.prints('> Bye, mate! Don\'t forget to visit me soon')
  end

  private

  attr_reader :vending_machine, :input, :output

  def print_available_coins_info
    output.prints("> I support the following coins:")
    coins_presenters = vending_machine.available_coins.map { |c| CoinPresenter.new(c) }
    coins_presenters.each do |coin_presenter|
      output.prints(coin_presenter.to_string_row)
    end
  end

  def start_selling_session
    loop do
      output.prints
      print_products
      output.prints
      product_id = input.prompt('> What would you like to purchase?')
      break if cancel_action?(product_id)

      product = vending_machine.product_by_id(product_id)
      if product
        begin_purchase(Purchase.new(product))
      else
        output.prints("\n> Sorry, I don't have a product associated with your request: #{product_id}\n")
      end
    end
  end

  def print_products
    output.prints("> That's what I have for you:")
    products_presenters = vending_machine.products.map { |p| ProductPresenter.new(p) }
    products_presenters.each do |product_presenter|
      output.prints(product_presenter.to_string_row)
    end
  end

  def cancel_action?(input_text)
    input_text.match?(/^cancel|exit$/)
  end

  def begin_purchase(purchase)
    output.prints("\n> Your've chosen the product '#{purchase.product_name}'...")
    until purchase.enough_coins_to_buy? do
      coin_code = input.prompt("> Insert the coin (#{human_price(purchase.waiting_amount)}): ")
      coin = vending_machine.coin_by_code(coin_code)
      if coin
        purchase.add_coin(coin)
      else
        output.prints("> Sorry, I don't know the coin '#{coin_code}'. Please, try again another one.")
      end
    end
    output.prints("\nThank you for your choice! bon appétit!")
  end
end
