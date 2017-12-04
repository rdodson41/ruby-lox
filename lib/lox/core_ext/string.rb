module Lox
  module CoreExt
    module String
      def match?(pattern)
        !match(pattern).nil?
      end
    end
  end
end

String.prepend(Lox::CoreExt::String)
