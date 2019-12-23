class Application
  def initialize(vending_machine, input, output)
    @vending_machine = vending_machine
    @input = input
    @output = output
  end

  def start
    output.prints('> Hi, mate! Welcome to my vending machine!')
    output.prints
    print_available_coins_info
    output.prints
    start_selling_session
  end

  private

  attr_reader :vending_machine, :input, :output

  def print_available_coins_info
    output.prints("> I support the following coins:")
    vending_machine.available_coins.each do |coin|
      output.prints(coin.code.rjust(5))
    end
  end

  def start_selling_session
    print_products
    output.prints
    output.prints('> What would you like to purchase?')
  end

  def print_products
    output.prints("That's what I have for you:")
    vending_machine.products.each do |product|
      output.prints(product.id.to_s.ljust(5) + product.name.ljust(20) + product.human_price.rjust(10))
    end
  end
end
