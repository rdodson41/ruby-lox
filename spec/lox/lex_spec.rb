require 'lox/lex'
require 'lox/lexical_analyzer'

RSpec.describe Lox::Lex do
  subject :lex do
    described_class.new(input, output)
  end

  let :input do
    instance_double(Lox::LexicalAnalyzer)
  end

  let :output do
    instance_double(IO)
  end

  describe '#call' do
    subject :call do
      lex.call
    end

    let :input_tokens do
      [
        [:identifier, 'print'],
        ['('],
        [:string, 'Hello, world!'],
        [')'],
        [';']
      ]
    end

    let :output_tokens do
      []
    end

    let :tokens do
      input_tokens.map(&:to_json)
    end

    before do
      allow(input).to receive(:each_token) do |&block|
        input_tokens.each(&block)
      end
      allow(output).to receive(:puts) do |token|
        output_tokens << token
      end
    end

    it 'writes tokens to output' do
      expect { call }.to change { output_tokens }.to(tokens)
    end
  end
end
