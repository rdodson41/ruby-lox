module Lox
  class Scanner
    attr_reader :input

    def initialize(input)
      @input = input
    end

    def each_char
      return enum_for(:each_char) unless block_given?
      input.each_line do |line|
        line.each_char do |character|
          yield(character)
        end
      end
    end
  end
end
