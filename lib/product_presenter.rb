# frozen_string_literal: true

require 'delegate'
require_relative "./helpers/human_price_helper"

class ProductPresenter < SimpleDelegator
  include Helpers::HumanPriceHelper

  def to_string_row
    id.to_s.ljust(5) + name.ljust(20) + human_price(price).rjust(10)
  end
end
