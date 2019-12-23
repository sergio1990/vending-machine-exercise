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
    print_supported_coins_info
    start_selling_session
    output.prints('>' * 10)
    output.prints('> Bye, mate! Don\'t forget to visit me soon')
  end

  private

  attr_reader :vending_machine, :input, :output

  def print_supported_coins_info
    output.prints("> I support the following coins:")
    vending_machine.supported_coin_codes.each do |coin_code|
      output.prints(coin_code.rjust(5))
    end
  end

  def start_selling_session
    loop do
      output.prints
      print_assortment
      output.prints
      product_id = input.prompt('> What would you like to purchase?')
      break if cancel_action?(product_id)

      begin
        purchase_id = vending_machine.purchase(product_id)
      rescue VendingMachine::InvalidProductCodeError, VendingMachine::OutOfStockError => e
        output.prints("\n> #{e.message}\n")
      end
    end
  end

  def print_assortment
    output.prints("> That's what I have for you:")
    vending_machine.assortment.map { |p| ProductItemPresenter.new(p) }.each do |product_item|
      output.prints(product_item.to_string_row)
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
