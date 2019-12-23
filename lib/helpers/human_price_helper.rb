module Helpers
  module HumanPriceHelper
    def human_price(price)
      price < 100 ? "#{price}¢" : "$#{price / 100.0}"
    end
  end
end
