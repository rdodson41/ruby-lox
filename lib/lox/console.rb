# frozen_string_literal: true

module Lox
  class Console
    attr_reader :terminal

    def initialize(terminal)
      @terminal = terminal
    end

    def each_line
      return enum_for(:each_line) unless block_given?

      while (line = readline)
        yield("#{line}\n")
      end
    end

    private

    def readline
      terminal.readline('$ ', true)
    end
  end
end
