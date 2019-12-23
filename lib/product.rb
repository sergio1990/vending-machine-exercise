# frozen_string_literal: true

Product = Struct.new(:id, :name, :price) do
  def human_price
    @human_price ||= price < 100 ? "#{price}¢" : "$#{price / 100.0}"
  end
end
