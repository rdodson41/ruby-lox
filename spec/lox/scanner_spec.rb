require 'lox/scanner'

RSpec.describe Lox::Scanner do
  subject :scanner do
    described_class.new(input)
  end

  let :input do
    instance_double(IO)
  end

  describe '#each_char' do
    subject :each_char do
      scanner.each_char
    end

    let :input_lines do
      [
        "print(\"Hello, world!\");\n"
      ]
    end

    let :characters do
      input_lines.flat_map(&:chars)
    end

    before do
      allow(input).to receive(:each_line) do |&block|
        input_lines.each(&block)
      end
    end

    it 'yields characters' do
      expect { |block| each_char.each(&block) }
        .to yield_successive_args(*characters)
    end
  end
end
