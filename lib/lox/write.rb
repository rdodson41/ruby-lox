# frozen_string_literal: true

module Lox
  class Write
    attr_reader :objects
    attr_reader :output

    def initialize(objects, output)
      @objects = objects
      @output = output
    end

    def call
      objects.each(&block)
    end

    private

    def block
      output.public_method(:puts)
    end
  end
end
