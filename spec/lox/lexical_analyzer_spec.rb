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

    around do |example|
      Timeout.timeout(1, &example)
    end

    context 'with a comment' do
      let :input_characters do
        "# Your first Lox program!\nprint\n".chars
      end

      let :tokens do
        [
          [:identifier, 'print']
        ]
      end

      it 'yields tokens' do
        expect { |block| each_token.each(&block) }
          .to yield_successive_args(*tokens)
      end
    end

    context 'with an integer' do
      let :input_characters do
        "1234;\n".chars
      end

      let :tokens do
        [
          [:integer, 1234],
          [';']
        ]
      end

      it 'yields tokens' do
        expect { |block| each_token.each(&block) }
          .to yield_successive_args(*tokens)
      end
    end

    context 'with a string' do
      let :input_characters do
        "\"Hello, world!\"\n".chars
      end

      let :tokens do
        [
          [:string, 'Hello, world!']
        ]
      end

      it 'yields tokens' do
        expect { |block| each_token.each(&block) }
          .to yield_successive_args(*tokens)
      end
    end

    context 'with an identifier' do
      let :input_characters do
        "print\n".chars
      end

      let :tokens do
        [
          [:identifier, 'print']
        ]
      end

      it 'yields tokens' do
        expect { |block| each_token.each(&block) }
          .to yield_successive_args(*tokens)
      end
    end

    context 'with an operator' do
      let :input_characters do
        ";\n".chars
      end

      let :tokens do
        [
          [';']
        ]
      end

      it 'yields tokens' do
        expect { |block| each_token.each(&block) }
          .to yield_successive_args(*tokens)
      end
    end

    context 'with a non-compound operator' do
      let :input_characters do
        "<\n".chars
      end

      let :tokens do
        [
          ['<']
        ]
      end

      it 'yields tokens' do
        expect { |block| each_token.each(&block) }
          .to yield_successive_args(*tokens)
      end
    end

    context 'with a compound operator' do
      let :input_characters do
        "<=\n".chars
      end

      let :tokens do
        [
          ['<=']
        ]
      end

      it 'yields tokens' do
        expect { |block| each_token.each(&block) }
          .to yield_successive_args(*tokens)
      end
    end

    context 'with a terminating integer' do
      let :input_characters do
        '1234'.chars
      end

      let :tokens do
        [
          [:integer, 1234]
        ]
      end

      it 'yields tokens' do
        expect { |block| each_token.each(&block) }
          .to yield_successive_args(*tokens)
      end
    end

    context 'with a terminating identifier' do
      let :input_characters do
        'print'.chars
      end

      let :tokens do
        [
          [:identifier, 'print']
        ]
      end

      it 'yields tokens' do
        expect { |block| each_token.each(&block) }
          .to yield_successive_args(*tokens)
      end
    end

    context 'with a terminating, non-compound operator' do
      let :input_characters do
        '<'.chars
      end

      let :tokens do
        [
          ['<']
        ]
      end

      it 'yields tokens' do
        expect { |block| each_token.each(&block) }
          .to yield_successive_args(*tokens)
      end
    end

    context 'with an invalid character' do
      let :input_characters do
        '&'.chars
      end

      it 'raises an error' do
        expect { each_token.to_a }.to raise_error(
          Lox::LexicalAnalyzer::InvalidCharacter,
          'Invalid character: &'
        )
      end
    end

    context 'with an unterminated string' do
      let :input_characters do
        '"Hello, world!'.chars
      end

      it 'raises an error' do
        expect { each_token.to_a }.to raise_error(
          Lox::LexicalAnalyzer::UnterminatedString,
          'Unterminated string: "Hello, world!'
        )
      end
    end
  end
end
