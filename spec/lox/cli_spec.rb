require 'lox/cli'

RSpec.describe Lox::CLI do
  subject :cli do
    described_class.new
  end

  describe '#read' do
    let :console do
      instance_double(Lox::Console)
    end

    let :read do
      instance_spy(Lox::Read)
    end

    before do
      allow(Lox::Console).to receive(:new).with(Readline) do
        console
      end
      allow(Lox::Read).to receive(:new).with(console, STDOUT) do
        read
      end
    end

    it 'reads lines from the console' do
      cli.read
      expect(read).to have_received(:call)
    end
  end
end
