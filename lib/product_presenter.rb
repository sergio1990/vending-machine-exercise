# frozen_string_literal: true

require 'delegate'

class ProductPresenter < SimpleDelegator
  def to_string_row
    id.to_s.ljust(5) + name.ljust(20) + human_price.rjust(10)
  end

  private

  def human_price
    price < 100 ? "#{price}¢" : "$#{price / 100.0}"
  end
end
