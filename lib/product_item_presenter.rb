# frozen_string_literal: true

require 'delegate'
require_relative "./helpers/human_price_helper"

class ProductItemPresenter < SimpleDelegator
  include Helpers::HumanPriceHelper

  def to_string_row
    product_id.to_s.ljust(5) + "#{amount}x".rjust(5) + " " + product_name.ljust(20) + human_price(product_price).rjust(10)
  end
end
