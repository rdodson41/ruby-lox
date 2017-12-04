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

    before do
      allow(input).to receive(:each_char) do |&block|
        input_characters.each(&block)
      end
    end

    context 'with a comment' do
      let :input_characters do
        '# this is a comment'.chars
      end

      let :tokens do
        []
      end

      it 'yields tokens' do
        expect { |block| each_token.each(&block) }
          .to yield_successive_args(*tokens)
      end
    end

    context 'with an expression' do
      let :input_characters do
        'index == 12 + 34'.chars
      end

      let :tokens do
        [
          [:identifier, 'index'],
          ['=='],
          [:integer, 12],
          ['+'],
          [:integer, 34]
        ]
      end

      it 'yields tokens' do
        expect { |block| each_token.each(&block) }
          .to yield_successive_args(*tokens)
      end
    end

    context 'with an expression' do
      let :input_characters do
        'count != 56 * index'.chars
      end

      let :tokens do
        [
          [:identifier, 'count'],
          ['!='],
          [:integer, 56],
          ['*'],
          [:identifier, 'index']
        ]
      end

      it 'yields tokens' do
        expect { |block| each_token.each(&block) }
          .to yield_successive_args(*tokens)
      end
    end

    context 'with a statement' do
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

      it 'yields tokens' do
        expect { |block| each_token.each(&block) }
          .to yield_successive_args(*tokens)
      end
    end
  end
end
