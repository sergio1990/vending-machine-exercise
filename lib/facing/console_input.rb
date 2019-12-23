# frozen_string_literal: true

module Facing
  class ConsoleInput
    def prompt(hint)
      print "#{hint}: "
      gets.chomp
    end
  end
end
