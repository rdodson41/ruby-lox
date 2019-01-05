require('lox/console')
require('lox/formatter')
require('lox/lexical_analyzer')
require('lox/scanner')
require('lox/write')
require('thor')

module Lox
  class CLI < Thor
    desc 'read', 'Read input from the console and ' \
                 'write lines to standard output'
    def read
      Write.new(lines, STDOUT).call
    end

    desc 'scan', 'Scan input from the console and ' \
                 'write characters to standard output'
    def scan
      Write.new(characters, STDOUT).call
    end

    desc 'lex', 'Perform lexical analysis of input from the console and ' \
                'write tokens to standard output'
    def lex
      Write.new(tokens, STDOUT).call
    end

    private

    def lines
      Formatter.new(console.each_line)
    end

    def characters
      Formatter.new(scanner.each_char)
    end

    def tokens
      Formatter.new(lexical_analyzer.each_token)
    end

    def console
      Console.new(Readline)
    end

    def scanner
      Scanner.new(console)
    end

    def lexical_analyzer
      LexicalAnalyzer.new(scanner)
    end
  end
end
