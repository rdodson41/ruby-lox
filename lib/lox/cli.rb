require 'lox/console'
require 'lox/read'
require 'thor'

module Lox
  class CLI < Thor
    desc 'read', 'Read lines from the console and write them to standard output'
    def read
      Read.new(Console.new(Readline), STDOUT).call
    end
  end
end
