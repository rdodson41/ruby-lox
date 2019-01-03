# frozen_string_literal: true

module Lox
  class LexicalAnalyzer
    class InvalidCharacter < StandardError
      def initialize(character)
        super("Invalid character: #{character}")
      end
    end
  end
end
