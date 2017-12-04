require 'lox/lexical_analyzer/invalid_character'
require 'lox/lexical_analyzer/unterminated_string'

module Lox
  class LexicalAnalyzer
    attr_reader :input

    def initialize(input)
      @input = input
    end

    def each_token(&block)
      return enum_for(:each_token) unless block_given?
      characters = input.each_char
      loop do
        match_token(characters, &block)
      end
    end

    private

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/MethodLength
    def match_token(characters, &block)
      case character = characters.next
      when /\s/
        nil
      when /[#]/
        match_comment(characters)
      when /\d/
        match_integer(characters, character, &block)
      when /["]/
        match_string(characters, character, &block)
      when /[a-zA-Z_]/
        match_identifier(characters, character, &block)
      when /[!=<>]/
        match_operator(characters, character, &block)
        # rubocop:disable Style/RegexpLiteral
      when /[(){},.\-+;*\/]/
        # rubocop:enable Style/RegexpLiteral
        yield([character])
      else
        raise(InvalidCharacter, character)
      end
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/MethodLength

    def match_comment(characters)
      characters.next while characters.peek.match?(/./)
    end

    def match_integer(characters, lexeme)
      lexeme << characters.next while characters.peek.match?(/\d/)
      yield([:integer, Integer(lexeme)])
    rescue StopIteration
      yield([:integer, Integer(lexeme)])
    end

    def match_string(characters, lexeme)
      lexeme << characters.next until characters.peek.match?(/["]/)
      lexeme << characters.next
      yield([:string, lexeme[1..-2]])
    rescue StopIteration
      raise(UnterminatedString, lexeme)
    end

    def match_identifier(characters, lexeme)
      lexeme << characters.next while characters.peek.match?(/\w/)
      yield([:identifier, lexeme])
    rescue StopIteration
      yield([:identifier, lexeme])
    end

    def match_operator(characters, lexeme)
      lexeme << characters.next if characters.peek.match?(/[=]/)
      yield([lexeme])
    rescue StopIteration
      yield([lexeme])
    end
  end
end
