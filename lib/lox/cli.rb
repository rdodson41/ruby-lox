require 'lox/console'
require 'lox/lex'
require 'lox/lexical_analyzer'
require 'lox/read'
require 'lox/scan'
require 'lox/scanner'
require 'thor'

module Lox
  class CLI < Thor
    desc 'read', 'Read lines from the console and ' \
                 'write them to standard output'
    def read
      Read.new(console, STDOUT).call
    end

    desc 'scan', 'Scan characters from the console and ' \
                 'write them to standard output'
    def scan
      Scan.new(scanner, STDOUT).call
    end

    desc 'lex', 'Perform lexical analysis of characters from the console and ' \
                'write tokens to standard output'
    def lex
      Lex.new(lexical_analyzer, STDOUT).call
    end

    private

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
