# frozen_string_literal: true

require('lox/cli')

RSpec.describe(Lox::CLI) do
  subject :cli do
    described_class.new
  end

  let :formatter do
    instance_double(Lox::Formatter)
  end

  let :command do
    instance_spy(Lox::Write)
  end

  before do
    allow(Lox::Write).to(receive(:new).with(formatter, STDOUT)) do
      command
    end
  end

  describe '#read' do
    subject :read do
      cli.read
    end

    let :console do
      instance_double(Lox::Console, each_line: each_line)
    end

    let :each_line do
      instance_double(Enumerator)
    end

    before do
      allow(Lox::Console).to(receive(:new).with(Readline)) do
        console
      end
      allow(Lox::Formatter).to(receive(:new).with(each_line)) do
        formatter
      end
    end

    it 'writes lines to standard output' do
      read
      expect(command).to(have_received(:call))
    end
  end

  describe '#scan' do
    subject :scan do
      cli.scan
    end

    let :console do
      instance_double(Lox::Console)
    end

    let :scanner do
      instance_double(Lox::Scanner, each_char: each_char)
    end

    let :each_char do
      instance_double(Enumerator)
    end

    before do
      allow(Lox::Console).to(receive(:new)) do
        console
      end
      allow(Lox::Scanner).to(receive(:new).with(console)) do
        scanner
      end
      allow(Lox::Formatter).to(receive(:new).with(each_char)) do
        formatter
      end
    end

    it 'writes characters to standard output' do
      scan
      expect(command).to(have_received(:call))
    end
  end

  describe '#lex' do
    subject :lex do
      cli.lex
    end

    let :scanner do
      instance_double(Lox::Scanner)
    end

    let :lexical_analyzer do
      instance_double(Lox::LexicalAnalyzer, each_token: each_token)
    end

    let :each_token do
      instance_double(Enumerator)
    end

    before do
      allow(Lox::Scanner).to(receive(:new)) do
        scanner
      end
      allow(Lox::LexicalAnalyzer).to(receive(:new).with(scanner)) do
        lexical_analyzer
      end
      allow(Lox::Formatter).to(receive(:new).with(each_token)) do
        formatter
      end
    end

    it 'writes tokens to standard output' do
      lex
      expect(command).to(have_received(:call))
    end
  end
end
