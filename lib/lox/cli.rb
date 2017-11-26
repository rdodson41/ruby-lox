require 'lox/console'
require 'lox/read'
require 'lox/scan'
require 'lox/scanner'
require 'thor'

module Lox
  class CLI < Thor
    desc 'read', 'Read lines from the console and ' \
                 'write them to standard output'
    def read
      Read.new(Console.new(Readline), STDOUT).call
    end

    desc 'scan', 'Scan characters from the console and ' \
                 'write them to standard output'
    def scan
      Scan.new(Scanner.new(Console.new(Readline)), STDOUT).call
    end
  end
end
