module Lox
  module Commands
    class Write
      attr_reader :objects
      attr_reader :output

      def initialize(objects, output)
        @objects = objects
        @output = output
      end

      def call
        objects.each(&writer)
      end

      private

      def writer
        output.public_method(:puts)
      end
    end
  end
end
