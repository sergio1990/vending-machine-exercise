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
    coins_presenters = vending_machine.available_coins.map { |c| CoinPresenter.new(c) }
    coins_presenters.each do |coin_presenter|
      output.prints(coin_presenter.to_string_row)
    end
  end

  def start_selling_session
    print_products
    output.prints
    input.prompt('> What would you like to purchase?')
  end

  def print_products
    output.prints("That's what I have for you:")
    products_presenters = vending_machine.products.map { |p| ProductPresenter.new(p) }
    products_presenters.each do |product_presenter|
      output.prints(product_presenter.to_string_row)
    end
  end
end
