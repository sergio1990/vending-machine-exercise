# frozen_string_literal: true

require 'delegate'

class CoinPresenter < SimpleDelegator
  def to_string_row
    code.rjust(5)
  end
end

