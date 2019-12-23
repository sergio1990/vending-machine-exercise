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
      print_coins_in_bank_info
      output.prints
      print_assortment
      output.prints
      product_id = input.prompt('> What would you like to purchase? (enter `cancel` or `exit` to quit)')
      break if cancel_action?(product_id)

      begin
        purchase_id = vending_machine.purchase(product_id)
        pay_for_purchase(purchase_id)
      rescue VendingMachine::InvalidProductCodeError, VendingMachine::OutOfStockError => e
        output.prints("\n> #{e.message}\n")
      end
    end
  end

  def print_coins_in_bank_info
    output.prints("> I have the following coins in my bank:")
    vending_machine.available_coins.group_by { |coin| coin.code }.each do |code, items|
      amount = items.size
      output.prints("#{amount}x ".rjust(5) + code.rjust(5))
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

  def pay_for_purchase(purchase_id)
    output.prints("\n> It's time to pay! Please, insert coins in total amount of #{human_price(vending_machine.waiting_amount(purchase_id))}")
    # Catch the case when the product is free
    unless vending_machine.enough_coins?(purchase_id)
      loop do
        coin_code = input.prompt("> Insert the coin (#{human_price(vending_machine.waiting_amount(purchase_id))} left): ")
        begin
          break unless vending_machine.insert_coin(coin_code, purchase_id)
        rescue VendingMachine::InvalidCoinError => e
          output.prints("\n> #{e.message}\n")
        end
      end
    end

    output.prints("\nThank you for your choice! bon appétit!")
  end
end
