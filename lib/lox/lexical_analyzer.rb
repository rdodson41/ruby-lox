require('lox/lexical_analyzer/invalid_character')
require('lox/lexical_analyzer/invalid_state')
require('lox/lexical_analyzer/unterminated_string')

module Lox
  class LexicalAnalyzer
    attr_reader :input

    def initialize(input)
      @input = input
    end

    def each_token(&block)
      return enum_for(:each_token) unless block_given?

      state = :default
      lexeme = nil
      input.each_char do |character|
        state, lexeme = method(state).call(lexeme, character, &block)
      end
      eof(state, lexeme, &block)
    end

    # rubocop:disable Metrics/CyclomaticComplexity
    # rubocop:disable Metrics/MethodLength
    def default(_lexeme, character)
      case character
      when /\s/
        :default
      when /[#]/
        :comment
      when /\d/
        [:integer, character]
      when /["]/
        [:string, character]
      when /[a-zA-Z_]/
        [:identifier, character]
      when /[!=<>]/
        [:operator, character]
      when %r{[(){},.\-+;*\/]}
        yield([character])
        :default
      else
        raise(InvalidCharacter, character)
      end
    end
    # rubocop:enable Metrics/CyclomaticComplexity
    # rubocop:enable Metrics/MethodLength

    def comment(_lexeme, character)
      if character =~ /./
        :comment
      else
        :default
      end
    end

    def integer(lexeme, character, &block)
      if character =~ /\d/
        [:integer, lexeme + character]
      else
        yield([:integer, Integer(lexeme)])
        default(nil, character, &block)
      end
    end

    def string(lexeme, character)
      if character =~ /["]/
        yield([:string, lexeme[1..-1]])
        :default
      else
        [:string, lexeme + character]
      end
    end

    def identifier(lexeme, character, &block)
      if character =~ /\w/
        [:identifier, lexeme + character]
      else
        yield([:identifier, lexeme])
        default(nil, character, &block)
      end
    end

    def operator(lexeme, character, &block)
      if character =~ /[=]/
        yield([lexeme + character])
        :default
      else
        yield([lexeme])
        default(nil, character, &block)
      end
    end

    # rubocop:disable Metrics/MethodLength
    def eof(state, lexeme)
      case state
      when :default
        nil
      when :integer
        yield([:integer, Integer(lexeme)])
      when :string
        raise(UnterminatedString, lexeme)
      when :identifier
        yield([:identifier, lexeme])
      when :operator
        yield([lexeme])
      else
        raise(InvalidState, state)
      end
      # rubocop:enable Metrics/MethodLength
    end
  end
end
