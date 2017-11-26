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

  describe '#scan' do
    let :console do
      instance_double(Lox::Console)
    end

    let :scanner do
      instance_double(Lox::Scanner)
    end

    let :scan do
      instance_spy(Lox::Scan)
    end

    before do
      allow(Lox::Console).to receive(:new).with(Readline) do
        console
      end
      allow(Lox::Scanner).to receive(:new).with(console) do
        scanner
      end
      allow(Lox::Scan).to receive(:new).with(scanner, STDOUT) do
        scan
      end
    end

    it 'scans characters from the console' do
      cli.scan
      expect(scan).to have_received(:call)
    end
  end

  describe '#lex' do
    let :console do
      instance_double(Lox::Console)
    end

    let :scanner do
      instance_double(Lox::Scanner)
    end

    let :lexical_analyzer do
      instance_double(Lox::LexicalAnalyzer)
    end

    let :lex do
      instance_spy(Lox::Lex)
    end

    before do
      allow(Lox::Console).to receive(:new).with(Readline) do
        console
      end
      allow(Lox::Scanner).to receive(:new).with(console) do
        scanner
      end
      allow(Lox::LexicalAnalyzer).to receive(:new).with(scanner) do
        lexical_analyzer
      end
      allow(Lox::Lex).to receive(:new).with(lexical_analyzer, STDOUT) do
        lex
      end
    end

    it 'performs lexical analysis of characters from the console' do
      cli.lex
      expect(lex).to have_received(:call)
    end
  end
end
