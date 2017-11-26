require 'lox/scan'

RSpec.describe Lox::Scan do
  subject :scan do
    described_class.new(input, output)
  end

  let :input do
    instance_double(IO)
  end

  let :output do
    instance_double(IO)
  end

  describe '#call' do
    subject :call do
      scan.call
    end

    let :input_characters do
      "print(\"Hello, world!\");\n".chars
    end

    let :output_characters do
      []
    end

    let :characters do
      input_characters.map(&:to_json)
    end

    before do
      allow(input).to receive(:each_char) do |&block|
        input_characters.each(&block)
      end
      allow(output).to receive(:puts) do |character|
        output_characters << character
      end
    end

    it 'scans characters' do
      expect { call }.to change { output_characters }.to(characters)
    end
  end
end
