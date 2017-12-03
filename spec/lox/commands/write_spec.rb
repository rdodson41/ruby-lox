require 'lox/commands/write'

RSpec.describe Lox::Commands::Write do
  subject :write do
    described_class.new(objects, output)
  end

  let :objects do
    Array.new(2) { instance_double(Object) }
  end

  let :output do
    instance_double(IO)
  end

  describe '#call' do
    subject :call do
      write.call
    end

    let :writer do
      output_objects.public_method(:push)
    end

    let :output_objects do
      []
    end

    before do
      allow(output).to receive(:puts, &writer)
    end

    it 'writes objects to output' do
      expect { call }.to change { output_objects }.to(objects)
    end
  end
end
