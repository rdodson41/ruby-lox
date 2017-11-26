require 'json'

module Lox
  class Read
    attr_reader :input
    attr_reader :output

    def initialize(input, output)
      @input = input
      @output = output
    end

    def call
      input.each_line do |line|
        output.puts(line.to_json)
      end
    end
  end
end
