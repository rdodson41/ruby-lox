require 'lox/read'

RSpec.describe Lox::Read do
  subject :read do
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
      read.call
    end

    let :input_lines do
      [
        "print(\"Hello, world!\");\n"
      ]
    end

    let :output_lines do
      []
    end

    let :lines do
      input_lines.map(&:to_json)
    end

    before do
      allow(input).to receive(:each_line) do |&block|
        input_lines.each(&block)
      end
      allow(output).to receive(:puts) do |line|
        output_lines << line
      end
    end

    it 'reads lines' do
      expect { call }.to change { output_lines }.to(lines)
    end
  end
end
