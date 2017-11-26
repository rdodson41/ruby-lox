require 'lox/console'
require 'readline'
require 'timeout'

RSpec.describe Lox::Console do
  subject :console do
    described_class.new(terminal)
  end

  let :terminal do
    object_double(Readline)
  end

  describe '#each_line' do
    subject :each_line do
      console.each_line
    end

    let :terminal_lines do
      [
        'print("Hello, world!");'
      ]
    end

    let :lines do
      terminal_lines.map do |line|
        "#{line}\n"
      end
    end

    before do
      allow(terminal).to receive(:readline).with('$ ', true) do
        terminal_lines.shift
      end
    end

    around do |example|
      Timeout.timeout(1, &example)
    end

    it 'yields lines' do
      expect { |block| each_line.each(&block) }.to yield_successive_args(*lines)
    end
  end
end
