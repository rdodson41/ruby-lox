require 'json'

module Lox
  class Lex
    attr_reader :input
    attr_reader :output

    def initialize(input, output)
      @input = input
      @output = output
    end

    def call
      input.each_token do |token|
        output.puts(token.to_json)
      end
    end
  end
end
