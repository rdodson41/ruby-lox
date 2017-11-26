require 'lox/lexical_analyzer'

RSpec.describe Lox::LexicalAnalyzer do
  subject :lexical_analyzer do
    described_class.new(input)
  end

  let :input do
    instance_double(IO)
  end

  describe '#each_token' do
    subject :each_token do
      lexical_analyzer.each_token
    end

    let :input_characters do
      "print(\"Hello, world!\");\n".chars
    end

    let :tokens do
      [
        [:identifier, 'print'],
        ['('],
        [:string, 'Hello, world!'],
        [')'],
        [';']
      ]
    end

    before do
      allow(input).to receive(:each_char) do |&block|
        input_characters.each(&block)
      end
    end

    it 'yields tokens' do
      expect { |block| each_token.each(&block) }
        .to yield_successive_args(*tokens)
    end
  end
end
