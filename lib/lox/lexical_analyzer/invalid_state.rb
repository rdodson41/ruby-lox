# frozen_string_literal: true

module Lox
  class LexicalAnalyzer
    class InvalidState < StandardError
      def initialize(state)
        super("Invalid state: #{state}")
      end
    end
  end
end
