module Lox
  class LexicalAnalyzer
    class UnterminatedString < StandardError
      def initialize(lexeme)
        super("Unterminated string: #{lexeme}")
      end
    end
  end
end
