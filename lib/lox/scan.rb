require 'json'

module Lox
  class Scan
    attr_reader :input
    attr_reader :output

    def initialize(input, output)
      @input = input
      @output = output
    end

    def call
      input.each_char do |character|
        output.puts(character.to_json)
      end
    end
  end
end
