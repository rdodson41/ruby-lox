require 'lox/commands/write'
require 'lox/console'
require 'lox/lexical_analyzer'
require 'lox/scanner'
require 'thor'

module Lox
  class CLI < Thor
    desc 'read', 'Read input from the console and ' \
                 'write lines to standard output'
    def read
      Commands::Write.new(console.each_line, STDOUT).call
    end

    desc 'scan', 'Scan input from the console and ' \
                 'write characters to standard output'
    def scan
      Commands::Write.new(scanner.each_char, STDOUT).call
    end

    desc 'lex', 'Perform lexical analysis of input from the console and ' \
                'write tokens to standard output'
    def lex
      Commands::Write.new(lexical_analyzer.each_token, STDOUT).call
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
