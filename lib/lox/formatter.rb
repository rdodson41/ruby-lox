# frozen_string_literal: true

module Lox
  class Formatter
    attr_reader :objects

    def initialize(objects)
      @objects = objects
    end

    def each(&block)
      objects.lazy.map(&:inspect).each(&block)
    end
  end
end
