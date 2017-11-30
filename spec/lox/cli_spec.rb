require 'lox/cli'

RSpec.describe Lox::CLI do
  subject :cli do
    described_class.new
  end

  describe '#read' do
    subject :read do
      cli.read
    end

    let :console do
      instance_double(Lox::Console)
    end

    let :console_lines do
      [
        "print(\"Hello, world!\");\n"
      ]
    end

    let :output_lines do
      []
    end

    let :lines do
      console_lines.map(&:inspect)
    end

    before do
      allow(Lox::Console).to receive(:new).with(Readline) do
        console
      end
      allow(console).to receive(:each_line) do |&block|
        console_lines.each(&block)
      end
      allow(STDOUT).to receive(:puts) do |line|
        output_lines << line
      end
    end

    it 'writes lines to standard output' do
      expect { read }.to change { output_lines }.to(lines)
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
      instance_double(Lox::Scanner)
    end

    let :scanner_characters do
      "print(\"Hello, world!\");\n".chars
    end

    let :output_characters do
      []
    end

    let :characters do
      scanner_characters.map(&:inspect)
    end

    before do
      allow(Lox::Console).to receive(:new).with(Readline) do
        console
      end
      allow(Lox::Scanner).to receive(:new).with(console) do
        scanner
      end
      allow(scanner).to receive(:each_char) do |&block|
        scanner_characters.each(&block)
      end
      allow(STDOUT).to receive(:puts) do |character|
        output_characters << character
      end
    end

    it 'writes characters to standard output' do
      expect { scan }.to change { output_characters }.to(characters)
    end
  end

  describe '#lex' do
    subject :lex do
      cli.lex
    end

    let :console do
      instance_double(Lox::Console)
    end

    let :scanner do
      instance_double(Lox::Scanner)
    end

    let :lexical_analyzer do
      instance_double(Lox::LexicalAnalyzer)
    end

    let :lexical_analyzer_tokens do
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
      lexical_analyzer_tokens.map(&:inspect)
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
      allow(lexical_analyzer).to receive(:each_token) do |&block|
        lexical_analyzer_tokens.each(&block)
      end
      allow(STDOUT).to receive(:puts) do |token|
        output_tokens << token
      end
    end

    it 'writes tokens to standard output' do
      expect { lex }.to change { output_tokens }.to(tokens)
    end
  end
end
