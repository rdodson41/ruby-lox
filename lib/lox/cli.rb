require 'lox/console'
require 'lox/lexical_analyzer'
require 'lox/scanner'
require 'thor'

module Lox
  class CLI < Thor
    desc 'read', 'Read lines from the console and ' \
                 'write them to standard output'
    def read
      console.each_line(&writer)
    end

    desc 'scan', 'Scan characters from the console and ' \
                 'write them to standard output'
    def scan
      scanner.each_char(&writer)
    end

    desc 'lex', 'Perform lexical analysis of characters from the console and ' \
                'write tokens to standard output'
    def lex
      lexical_analyzer.each_token(&writer)
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

    def writer
      method(:write)
    end

    def write(line)
      STDOUT.puts(line.inspect)
    end
  end
end
